//
//  PostModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

public enum SourceType: String, ModelProtocol {
    case post, repost, quote
}

public struct PostModel: ModelProtocol {
    let uuid: String
    let content: String
    let createdAt: Date
    let user: UserModel?
    let source: SourceType
    let originalPosts: [PostModel]
}

extension PostModel: MappableProtocol {
    func mapToPersistenceObject() -> PostEntity {
        let entity = PostEntity()
        entity.uuid = uuid
        entity.content = content
        entity.createdAt = createdAt
        entity.user = user?.mapToPersistenceObject()
        entity.source = source.rawValue
        entity.originalPosts.append(objectsIn: originalPosts.map { $0.mapToPersistenceObject() })
        return entity
    }

    static func mapFromPersistenceObject(_ object: PostEntity) -> PostModel {
        PostModel(
            uuid: object.uuid,
            content: object.content,
            createdAt: object.createdAt,
            user: object.user != nil ? UserModel.mapFromPersistenceObject(object.user!) : nil,
            source: SourceType(rawValue: object.source) ?? .post,
            originalPosts: object.originalPosts.map {
                PostModel.mapFromPersistenceObject($0)
            }
        )
    }
}
