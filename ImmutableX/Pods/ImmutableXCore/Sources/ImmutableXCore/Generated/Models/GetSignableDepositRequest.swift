//
// GetSignableDepositRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetSignableDepositRequest: Codable, Hashable {

    /** Amount of the token the user is depositing */
    public private(set) var amount: String
    public private(set) var token: SignableToken
    /** User who is depositing */
    public private(set) var user: String

    public init(amount: String, token: SignableToken, user: String) {
        self.amount = amount
        self.token = token
        self.user = user
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case amount
        case token
        case user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(amount, forKey: .amount)
        try container.encode(token, forKey: .token)
        try container.encode(user, forKey: .user)
    }
}

