//
//  PostProvider.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

public protocol PostProvider {
    func addPost(_ post: PostModel) -> AnyPublisher<PostModel, Error>
    func getAllPosts() -> AnyPublisher<[PostModel], Error>
    func getPosts(by userId: String) -> AnyPublisher<[PostModel], Error>
    func getMyPosts(between startDate: Date, and endDate: Date, with userId: String) -> AnyPublisher<[PostModel], Error>
}
