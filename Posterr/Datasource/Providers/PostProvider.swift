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
}
