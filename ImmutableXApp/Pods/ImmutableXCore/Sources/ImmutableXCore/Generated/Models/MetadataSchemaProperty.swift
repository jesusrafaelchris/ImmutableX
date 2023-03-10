//
// MetadataSchemaProperty.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct MetadataSchemaProperty: Codable, Hashable {

    /** Sets the metadata as filterable */
    public private(set) var filterable: Bool
    /** Name of the metadata key */
    public private(set) var name: String
    /** Type of the metadata. Values: \"enum\", \"text\", \"boolean\", \"continuous\", \"discrete\" | Default: \"text\". Src: https://docs.x.immutable.com/docs/asset-metadata#property-type-mapping */
    public private(set) var type: String

    public init(filterable: Bool, name: String, type: String) {
        self.filterable = filterable
        self.name = name
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case filterable
        case name
        case type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filterable, forKey: .filterable)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
}

