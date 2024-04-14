//
//  RESTAuthenticationProxy.swift
//  MullvadREST
//
//  Created by pronebird on 16/04/2022.
//  Copyright © 2022 Mullvad VPN AB. All rights reserved.
//

import Foundation
import MullvadTypes
import Logging

extension REST {
    public final class AuthenticationProxy: Proxy<ProxyConfiguration> {
        private let logger = Logger(label: "AuthenticationProxy")
        public init(configuration: ProxyConfiguration) {
            super.init(
                name: "AuthenticationProxy",
                configuration: configuration,
                requestFactory: RequestFactory.withDefaultAPICredentials(
                    pathPrefix: "/auth/v1",
                    bodyEncoder: Coding.makeJSONEncoder()
                ),
                responseDecoder: Coding.makeJSONDecoder()
            )
                logger.debug("AuthenticationProxy initialized with configuration: \(configuration)")

        }

        public func getAccessToken(
            accountNumber: String,
            retryStrategy: REST.RetryStrategy,
            completion: @escaping ProxyCompletionHandler<AccessTokenData>
        ) -> Cancellable {
            let requestHandler = AnyRequestHandler { endpoint in
                var requestBuilder = try self.requestFactory.createRequestBuilder(
                    endpoint: endpoint,
                    method: .post,
                    pathTemplate: "token"
                )
                let request = AccessTokenRequest(accountNumber: accountNumber)
                try requestBuilder.setHTTPBody(value: request)

                // Log the endpoint URL
                //let endpointURL = "https://api.mullvad.net/auth/v1/token"
                let endpointURL = "https://api.unblockvpn.io/auth/v1/token"
                self.logger.info("Preparing POST request to \(endpoint) for account number: \(accountNumber)")
                
                // Log the request body
                if let requestBodyData = try? JSONEncoder().encode(request),
                    let requestBodyString = String(data: requestBodyData, encoding: .utf8) {
                    self.logger.debug("Request body:\n\(requestBodyString)")
                }
                return requestBuilder.getRequest()
            }

            let responseHandler = REST.defaultResponseHandler(
                decoding: AccessTokenData.self,
                with: responseDecoder
            )

            return addOperation(
                name: "get-access-token",
                retryStrategy: retryStrategy,
                requestHandler: requestHandler,
                responseHandler: responseHandler,
                completionHandler: completion
            )
        }
    }

    public struct AccessTokenData: Decodable {
        let accessToken: String
        let expiry: Date
    }

    private struct AccessTokenRequest: Encodable {
        let accountNumber: String
        enum CodingKeys: String, CodingKey {
            case accountNumber
        }
    }
}
