//
//  PostModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

enum SourceType {
    case post, repost, quote
}

struct PostModel {
    let uuid: String
    let content: String?
    let createdAt: Date
    let user: User
    let source: SourceType
    let earliestPosts: [PostModel]
}
