//
// ListMintsResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ListMintsResponse: Codable, Hashable {

    /** Generated cursor returned by previous query */
    public private(set) var cursor: String
    /** Remaining results flag. 1: there are remaining results matching this query, 0: no remaining results */
    public private(set) var remaining: Int
    /** Mints matching query parameters */
    public private(set) var result: [Mint]

    public init(cursor: String, remaining: Int, result: [Mint]) {
        self.cursor = cursor
        self.remaining = remaining
        self.result = result
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case cursor
        case remaining
        case result
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cursor, forKey: .cursor)
        try container.encode(remaining, forKey: .remaining)
        try container.encode(result, forKey: .result)
    }
}

