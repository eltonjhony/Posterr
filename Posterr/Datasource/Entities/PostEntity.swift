//
//  PostEntity.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift

public final class PostEntity: Object {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var content: String?
    @Persisted var createdAt: Date
    @Persisted var user: UserEntity?
    @Persisted var source: String
    @Persisted var earliestPosts: List<PostEntity>
}
