//
// TokensAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class TokensAPI {

    /**
     Get details of a token
     
     - parameter address: (path) Token Contract Address 
     - returns: TokenDetails
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getToken(address: String) async throws -> TokenDetails {
        var requestTask: RequestTask?
        return try await withTaskCancellationHandler {
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation { continuation in
                guard !Task.isCancelled else {
                  continuation.resume(throwing: CancellationError())
                  return
                }

                requestTask = getTokenWithRequestBuilder(address: address).execute { result in
                    switch result {
                    case let .success(response):
                        continuation.resume(returning: response.body)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        } onCancel: { [requestTask] in
            requestTask?.cancel()
        }
    }

    /**
     Get details of a token
     - GET /v1/tokens/{address}
     - Get details of a token
     - parameter address: (path) Token Contract Address 
     - returns: RequestBuilder<TokenDetails> 
     */
    open class func getTokenWithRequestBuilder(address: String) -> RequestBuilder<TokenDetails> {
        var localVariablePath = "/v1/tokens/{address}"
        let addressPreEscape = "\(APIHelper.mapValueToPathItem(address))"
        let addressPostEscape = addressPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{address}", with: addressPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<TokenDetails>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     Get a list of tokens
     
     - parameter address: (query) Contract address of the token (optional)
     - parameter symbols: (query) Token symbols for the token, e.g. ?symbols&#x3D;IMX,ETH (optional)
     - returns: ListTokensResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func listTokens(address: String? = nil, symbols: String? = nil) async throws -> ListTokensResponse {
        var requestTask: RequestTask?
        return try await withTaskCancellationHandler {
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation { continuation in
                guard !Task.isCancelled else {
                  continuation.resume(throwing: CancellationError())
                  return
                }

                requestTask = listTokensWithRequestBuilder(address: address, symbols: symbols).execute { result in
                    switch result {
                    case let .success(response):
                        continuation.resume(returning: response.body)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        } onCancel: { [requestTask] in
            requestTask?.cancel()
        }
    }

    /**
     Get a list of tokens
     - GET /v1/tokens
     - Get a list of tokens
     - parameter address: (query) Contract address of the token (optional)
     - parameter symbols: (query) Token symbols for the token, e.g. ?symbols&#x3D;IMX,ETH (optional)
     - returns: RequestBuilder<ListTokensResponse> 
     */
    open class func listTokensWithRequestBuilder(address: String? = nil, symbols: String? = nil) -> RequestBuilder<ListTokensResponse> {
        let localVariablePath = "/v1/tokens"
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "address": address?.encodeToJSON(),
            "symbols": symbols?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<ListTokensResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }
}
