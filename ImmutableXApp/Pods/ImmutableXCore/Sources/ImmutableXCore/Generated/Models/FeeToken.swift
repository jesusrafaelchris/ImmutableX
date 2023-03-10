//
// FeeToken.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct FeeToken: Codable, Hashable {

    public enum ModelType: String, Codable, CaseIterable {
        case eth = "ETH"
        case erc20 = "ERC20"
    }
    public private(set) var data: FeeData?
    /** Fee token type. One of ETH/ERC20 */
    public private(set) var type: ModelType?

    public init(data: FeeData? = nil, type: ModelType? = nil) {
        self.data = data
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(type, forKey: .type)
    }
}

