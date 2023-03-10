//
// Collection.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Collection: Codable, Hashable {

    /** Ethereum address of the ERC721 contract */
    public private(set) var address: String
    /** URL of the tile image for this collection */
    public private(set) var collectionImageUrl: String?
    /** Description of the collection */
    public private(set) var description: String?
    /** URL of the icon for this collection */
    public private(set) var iconUrl: String?
    /** URL of the metadata for this collection */
    public private(set) var metadataApiUrl: String?
    /** Name of the collection */
    public private(set) var name: String
    /** The collection's project ID */
    public private(set) var projectId: Int
    /** Project owner address */
    public private(set) var projectOwnerAddress: String

    public init(address: String, collectionImageUrl: String?, description: String?, iconUrl: String?, metadataApiUrl: String?, name: String, projectId: Int, projectOwnerAddress: String) {
        self.address = address
        self.collectionImageUrl = collectionImageUrl
        self.description = description
        self.iconUrl = iconUrl
        self.metadataApiUrl = metadataApiUrl
        self.name = name
        self.projectId = projectId
        self.projectOwnerAddress = projectOwnerAddress
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case address
        case collectionImageUrl = "collection_image_url"
        case description
        case iconUrl = "icon_url"
        case metadataApiUrl = "metadata_api_url"
        case name
        case projectId = "project_id"
        case projectOwnerAddress = "project_owner_address"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        try container.encode(collectionImageUrl, forKey: .collectionImageUrl)
        try container.encode(description, forKey: .description)
        try container.encode(iconUrl, forKey: .iconUrl)
        try container.encode(metadataApiUrl, forKey: .metadataApiUrl)
        try container.encode(name, forKey: .name)
        try container.encode(projectId, forKey: .projectId)
        try container.encode(projectOwnerAddress, forKey: .projectOwnerAddress)
    }
}

