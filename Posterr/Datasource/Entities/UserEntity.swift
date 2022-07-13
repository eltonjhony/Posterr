//
//  UserEntity.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift

public final class UserEntity: Object {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var username: String
    @Persisted var profilePicture: String
    @Persisted var createdAt: Date
    @Persisted var isCurrent: Bool
    
    @Persisted var repostsId: List<String>
    
    @Persisted var postsCount: Int
    @Persisted var repostsCount: Int
    @Persisted var quotePostingCount: Int
}
