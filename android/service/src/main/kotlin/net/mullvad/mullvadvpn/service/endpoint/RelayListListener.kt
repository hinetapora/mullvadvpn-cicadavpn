package net.mullvad.mullvadvpn.service.endpoint

import kotlin.properties.Delegates.observable
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.channels.ClosedReceiveChannelException
import kotlinx.coroutines.channels.actor
import kotlinx.coroutines.channels.trySendBlocking
import net.mullvad.mullvadvpn.lib.ipc.Event
import net.mullvad.mullvadvpn.lib.ipc.Request
import net.mullvad.mullvadvpn.model.Constraint
import net.mullvad.mullvadvpn.model.GeographicLocationConstraint
import net.mullvad.mullvadvpn.model.LocationConstraint
import net.mullvad.mullvadvpn.model.RelayConstraints
import net.mullvad.mullvadvpn.model.RelayList
import net.mullvad.mullvadvpn.model.RelaySettings
import net.mullvad.mullvadvpn.model.WireguardConstraints
import net.mullvad.mullvadvpn.service.MullvadDaemon

class RelayListListener(endpoint: ServiceEndpoint) {

    private val commandChannel = spawnActor()
    private val daemon = endpoint.intermittentDaemon

    private var selectedRelayLocation by
        observable<GeographicLocationConstraint?>(null) { _, _, _ ->
            commandChannel.trySendBlocking(Command.SetRelayLocation)
        }
    private var selectedWireguardConstraints by
        observable<WireguardConstraints?>(null) { _, _, _ ->
            commandChannel.trySendBlocking(Command.SetWireguardConstraints)
        }

    var relayList by
        observable<RelayList?>(null) { _, _, relays ->
            endpoint.sendEvent(Event.NewRelayList(relays))
        }
        private set

    init {
        daemon.registerListener(this) { newDaemon ->
            newDaemon?.let { daemon ->
                setUpListener(daemon)
                fetchInitialRelayList(daemon)
            }
        }

        endpoint.dispatcher.registerHandler(Request.SetRelayLocation::class) { request ->
            selectedRelayLocation = request.relayLocation
        }

        endpoint.dispatcher.registerHandler(Request.SetWireguardConstraints::class) { request ->
            selectedWireguardConstraints = request.wireguardConstraints
        }
    }

    fun onDestroy() {
        commandChannel.close()
        daemon.unregisterListener(this)
    }

    private fun setUpListener(daemon: MullvadDaemon) {
        daemon.onRelayListChange = { relayLocations -> relayList = relayLocations }
    }

    private fun fetchInitialRelayList(daemon: MullvadDaemon) {
        synchronized(this) {
            if (relayList == null) {
                relayList = daemon.getRelayLocations()
            }
        }
    }

    private fun spawnActor() =
        GlobalScope.actor<Command>(Dispatchers.Default, Channel.CONFLATED) {
            try {
                for (command in channel) {
                    when (command) {
                        Command.SetRelayLocation,
                        Command.SetWireguardConstraints -> updateRelayConstraints()
                    }
                }
            } catch (exception: ClosedReceiveChannelException) {
                // Closed sender, so stop the actor
            }
        }

    private suspend fun updateRelayConstraints() {
        val currentRelayConstraints = getCurrentRelayConstraints()
        val location: Constraint<LocationConstraint> =
            selectedRelayLocation?.let { location ->
                Constraint.Only(LocationConstraint.Location(location))
            }
                ?: currentRelayConstraints.location
        val wireguardConstraints: WireguardConstraints =
            selectedWireguardConstraints ?: currentRelayConstraints.wireguardConstraints

        val update =
            RelaySettings.Normal(
                RelayConstraints(
                    location = location,
                    wireguardConstraints = wireguardConstraints,
                    ownership = Constraint.Any(),
                    providers = Constraint.Any()
                )
            )

        daemon.await().setRelaySettings(update)
    }

    private suspend fun getCurrentRelayConstraints(): RelayConstraints =
        when (val relaySettings = daemon.await().getSettings()?.relaySettings) {
            is RelaySettings.Normal -> relaySettings.relayConstraints
            else ->
                RelayConstraints(
                    location = Constraint.Any(),
                    providers = Constraint.Any(),
                    ownership = Constraint.Any(),
                    wireguardConstraints = WireguardConstraints(Constraint.Any())
                )
        }

    companion object {
        private enum class Command {
            SetRelayLocation,
            SetWireguardConstraints
        }
    }
}
