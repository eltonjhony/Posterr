//
//  PostUpdatableTests.swift
//  PosterrTests
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import XCTest
import Nimble
import Combine

@testable import Posterr

class PostUpdatableTests: XCTestCase {

    private var userRepoMock: UserRepositoryMock!
    private var postRepoMock: PostRepositoryMock!

    private var usecase: PostUpdatable!
    
    private var cancellables = [AnyCancellable]()
    
    private var expectedSuccess = false
    private var expectedError: PostableError?
    
    override func setUp() {
        super.setUp()
        userRepoMock = .init()
        postRepoMock = .init()
        usecase = PostUpdatableUseCase(userRepository: userRepoMock, postRepository: postRepoMock)
        usecase.didError.sink { error in
            self.expectedError = error as? PostableError
        }.store(in: &self.cancellables)
        expectedSuccess = false
        usecase.didUpdate.sink { _ in
            self.expectedSuccess.toggle()
        }.store(in: &self.cancellables)
    }
    
    func test_submitPost_whenContentExceeded_shouldReturnError() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.models = [
            makePost(user, and: longContent)
        ]
        
        // Act
        self.usecase.post(with: self.longContent)
        
        // Assert
        expect(self.expectedError == .contentExceeded).toEventually(beTrue(), timeout: .seconds(3))
    }
    
    func test_submitPost_whenDailyLimitExceeded_shouldReturnError() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.models = makePosts(of: 5)
        
        // Act
        self.usecase.post(with: shortContent)
        
        // Assert
        expect(self.expectedError == .dailyLimitExceeded).toEventually(beTrue(), timeout: .seconds(3))
    }
    
    func test_submitPost_whenThereIsNoValidationError_shouldReturnSuccess() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.model = makePost(user)
        postRepoMock.models = makePosts(of: 4)
        
        // Act
        self.usecase.post(with: shortContent)
        
        // Assert
        expect(self.expectedSuccess).toEventually(beTrue(), timeout: .seconds(3))
    }

}

private extension PostUpdatableTests {
    private var shortContent: String { "Before starting, let’s quickly tackle what long-form content is and what it isn’t." }
    private var longContent: String { "Before starting, let’s quickly tackle what long-form content is and what it isn’t. Long-form content" +
        "is content that offers a lot of information and/or great depth of information on a given topic. Minimum length should range anywhere between" +
        "700 and 2,000 words. The upper limit is variable depending on several factors, including focus topic, scope, intended aims, and audience." +
        "Long-form content requires critical thinking. It is intended to be read (as opposed to skimmed). It is well-researched and contextual." +
        "It is not an article that jams as many keywords into a single page as possible. Long-form content must have substance and purpose in order" +
        "to rank highly and be deemed useful by readers. Sometimes long-form content is gated, meaning that the audience must submit personal information"
    }
    
    private func makePosts(of times: Int) -> [PostModel] {
        stride(from: 0, to: times, by: 1).map { _ in makePost(makeUser()) }
    }
    
    private func makeUser(isCurrent: Bool = true) -> UserModel {
        .init(uuid: UUID().uuidString, username: "eljholiveira", profilePicture: "", createdAt: Date(), isCurrent: isCurrent)
    }
    
    private func makePost(_ user: UserModel, and content: String = "test content") -> PostModel {
        .init(uuid: UUID().uuidString, content: content, createdAt: Date(), user: user, source: .post, originalPosts: [])
    }
}
