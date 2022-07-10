//
//  ProfileInfoModel.swift
//  Posterr
//
//  Created by Elton Jhony on 10.07.22.
//

import Foundation

public struct ProfileInfoModel {
    let currentUser: UserModel
    let posts: [PostModel]
    
    var postsCount: Int {
        posts.filter { $0.source == .post }.count
    }
    
    var repostCount: Int {
        posts.filter { $0.source == .repost }.count
    }
    
    var quoteCount: Int {
        posts.filter { $0.source == .quote }.count
    }
    
    var joinerDate: String {
        currentUser.createdAt.format(with: .MMMMddyyyy)
    }
}
