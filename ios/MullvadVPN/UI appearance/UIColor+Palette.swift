//
//  UIColor+Palette.swift
//  MullvadVPN
//
//  Created by pronebird on 20/03/2019.
//  Copyright © 2019 Mullvad VPN AB. All rights reserved.
//

import UIKit

extension UIColor {
    enum AccountTextField {
        enum NormalState {
            static let borderColor = secondaryColor
            static let textColor = darkGrayColor
            static let backgroundColor = UIColor.darkGrayColor
        }

        enum ErrorState {
            static let borderColor = dangerColor.withAlphaComponent(0.4)
            static let textColor = dangerColor
            static let backgroundColor = UIColor.darkGrayColor
        }

        enum AuthenticatingState {
            static let borderColor = secondaryColor
            static let textColor = darkGrayColor
            static let backgroundColor = UIColor.darkGrayColor
        }
    }

    enum TextField {
        static let placeholderTextColor = UIColor.darkGrayColor
        static let textColor = UIColor.darkGrayColor
        static let backgroundColor = UIColor.primaryColor //search box selected background color
        static let invalidInputTextColor = UIColor.dangerColor
    }

    enum SearchTextField {
        static let placeholderTextColor = TextField.placeholderTextColor
        static let inactivePlaceholderTextColor = UIColor.primaryColor
        static let textColor = TextField.textColor
        static let inactiveTextColor = UIColor.primaryColor
        static let backgroundColor = TextField.backgroundColor
        static let inactiveBackgroundColor = UIColor.primaryColor
        static let leftViewTintColor = UIColor.primaryColor
        static let inactiveLeftViewTintColor = UIColor.primaryColor
    }

    enum AppButton {
        static let normalTitleColor = UIColor.darkGrayColor
        static let highlightedTitleColor = UIColor.lightGray
        static let disabledTitleColor = UIColor.lightGray
    }

    enum Switch {
        static let borderColor = UIColor.darkGrayColor
        static let onThumbColor = successColor
        static let offThumbColor = dangerColor
    }

    // Relay availability indicator view
    enum RelayStatusIndicator {
        static let activeColor = successColor.withAlphaComponent(0.9)
        static let inactiveColor = dangerColor.withAlphaComponent(0.95)
        static let highlightColor = UIColor.lightGray
    }

    enum MainSplitView {
        static let dividerColor = UIColor.darkGrayColor
    }

    // Navigation bars
    enum NavigationBar {
        static let backButtonIndicatorColor = UIColor.darkGrayColor
        static let backButtonTitleColor = UIColor.darkGrayColor
        static let titleColor = UIColor.darkGrayColor
    }

    // Cells - these are the initial cells in the location table
    enum Cell {
        static let backgroundColor = softGreenColor
        static let disabledBackgroundColor = backgroundColor.darkened(by: 0.3)!

        static let selectedBackgroundColor = successColor
        static let disabledSelectedBackgroundColor = selectedBackgroundColor.darkened(by: 0.3)!

        static let selectedAltBackgroundColor = backgroundColor.darkened(by: 0.2)!

        static let titleTextColor = UIColor.darkGrayColor
        static let detailTextColor = UIColor.darkGrayColor

        static let disclosureIndicatorColor = UIColor.darkGrayColor
    }

    enum SubCell {
        static let backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0) // Slightly darker off white (#DFDFDF) second cell in location select
    }

    enum SubSubCell {
        static let backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0) // Slightly darker off white (#DFDFDF) third cell in location select
    }

    enum HeaderBar {
        static let defaultBackgroundColor = primaryColor
        static let unsecuredBackgroundColor = dangerColor
        static let securedBackgroundColor = successColor
        static let dividerColor = secondaryColor
        static let brandNameColor = UIColor.darkGrayColor
        static let buttonColor = UIColor.darkGrayColor
        static let disabledButtonColor = UIColor.darkGrayColor
    }

    enum InAppNotificationBanner {
        static let errorIndicatorColor = dangerColor
        static let successIndicatorColor = successColor
        static let warningIndicatorColor = warningColor

        static let titleColor = UIColor.offWhiteColor //account credit expires soon
        static let bodyColor = UIColor.offWhiteColor //x hours left buy more credit
        static let actionButtonColor = UIColor.darkGrayColor
    }

    // Common colors
/*     static let primaryColor = UIColor(red: 0.16, green: 0.30, blue: 0.45, alpha: 1.0) //medium blue
    static let secondaryColor = UIColor(red: 0.10, green: 0.18, blue: 0.27, alpha: 1.0) //dark blue
    static let dangerColor = UIColor(red: 0.89, green: 0.25, blue: 0.22, alpha: 1.0) //red
    static let warningColor = UIColor(red: 1.0, green: 0.84, blue: 0.14, alpha: 1.0) //yellow
    static let successColor = UIColor(red: 0.27, green: 0.68, blue: 0.30, alpha: 1.0) //green */

/*     static let primaryColor = UIColor(red: 0.16, green: 0.30, blue: 0.45, alpha: 1.0) //medium blue - switch to #F8F8F8 equivalent in RGBA (off white)
    static let secondaryColor = UIColor(red: 0.10, green: 0.18, blue: 0.27, alpha: 1.0) //dark blue - switch to #DFDFDF equivalent in RGBA (slightly darker off white)
    static let dangerColor = UIColor(red: 0.89, green: 0.25, blue: 0.22, alpha: 1.0) //red - switch to #FFB865 equivalent in RGBA (soft orange)rgb(255, 184, 101)
    static let warningColor = UIColor(red: 1.0, green: 0.84, blue: 0.14, alpha: 1.0) //yellow - switch to #A3D9A5 equivalent in RGBA (soft green)rgb(163, 217, 165)
    static let successColor = UIColor(red: 0.27, green: 0.68, blue: 0.30, alpha: 1.0) //green - switch to #A3D9A5 equivalent in RGBA (soft green)rgb(163, 217, 165)
 */

    static let darkGrayColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0) //dark gray text
    static let softGreenColor = UIColor(red: 0.639, green: 0.851, blue: 0.647, alpha: 1.0) // Soft green (#A3D9A5)rgb(163, 217, 165)

    static let primaryColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1.0) // Off white (#F8F8F8)
    static let secondaryColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0) // Slightly darker off white (#DFDFDF)
    static let dangerColor = UIColor(red: 1.000, green: 0.722, blue: 0.396, alpha: 1.0) // Soft orange (#FFB865)rgb(255, 184, 101)
    static let warningColor = UIColor(red: 0.639, green: 0.851, blue: 0.647, alpha: 1.0) // Soft green (#A3D9A5)rgb(163, 217, 165)
    static let successColor = UIColor(red: 0.639, green: 0.851, blue: 0.647, alpha: 1.0) // Soft green (#A3D9A5)rgb(163, 217, 165)
    static let offWhiteColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1.0) // Off white (#F8F8F8)

}
