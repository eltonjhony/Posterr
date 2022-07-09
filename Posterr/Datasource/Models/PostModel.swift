//
//  PostModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

public enum SourceType: ModelProtocol {
    case post, repost, quote
}

public struct PostModel: ModelProtocol {
    let uuid: String
    let content: String?
    let createdAt: Date
    let user: UserModel
    let source: SourceType
    let earliestPosts: [PostModel]
}
