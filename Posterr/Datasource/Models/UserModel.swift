//
//  UserModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

public struct UserModel: ModelProtocol {
    let uuid: String
    let username: String
    let profilePicture: String
    let createdAt: Date
    var isCurrent: Bool
    
    var repostsId: [String] = []
    
    var postsCount: Int = 0
    var repostsCount: Int = 0
    var quotePostingCount: Int = 0
}

extension UserModel: MappableProtocol {
    func mapToPersistenceObject() -> UserEntity {
        let entity = UserEntity()
        entity.uuid = uuid
        entity.username = username
        entity.profilePicture = profilePicture
        entity.createdAt = createdAt
        entity.isCurrent = isCurrent
        entity.repostsId.append(objectsIn: repostsId)
        entity.postsCount = postsCount
        entity.repostsCount = repostsCount
        entity.quotePostingCount = quotePostingCount
        return entity
    }

    static func mapFromPersistenceObject(_ object: UserEntity) -> UserModel {
        UserModel(
            uuid: object.uuid,
            username: object.username,
            profilePicture: object.profilePicture,
            createdAt: object.createdAt,
            isCurrent: object.isCurrent,
            repostsId: Array(object.repostsId),
            postsCount: object.postsCount,
            repostsCount: object.repostsCount,
            quotePostingCount: object.quotePostingCount
        )
    }
}

extension UserModel {
    func changing(change: (inout UserModel) -> Void) -> UserModel {
        var user = self
        change(&user)
        return user
    }
}
