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
    let isCurrent: Bool
}

extension UserModel: MappableProtocol {
    func mapToPersistenceObject() -> UserEntity {
        let entity = UserEntity()
        entity.uuid = uuid
        entity.username = username
        entity.profilePicture = profilePicture
        entity.createdAt = createdAt
        entity.isCurrent = isCurrent
        return entity
    }

    static func mapFromPersistenceObject(_ object: UserEntity) -> UserModel {
        UserModel(
            uuid: object.uuid,
            username: object.username,
            profilePicture: object.profilePicture,
            createdAt: object.createdAt,
            isCurrent: object.isCurrent
        )
    }
}
