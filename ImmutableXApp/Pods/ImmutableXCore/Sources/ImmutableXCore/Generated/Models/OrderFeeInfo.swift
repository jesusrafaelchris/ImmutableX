//
// OrderFeeInfo.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct OrderFeeInfo: Codable, Hashable {

    public private(set) var address: String?
    public private(set) var amount: String?
    public private(set) var token: FeeToken?
    /** Fee type */
    public private(set) var type: String?

    public init(address: String? = nil, amount: String? = nil, token: FeeToken? = nil, type: String? = nil) {
        self.address = address
        self.amount = amount
        self.token = token
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case address
        case amount
        case token
        case type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(type, forKey: .type)
    }
}

