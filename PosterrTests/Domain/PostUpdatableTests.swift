//
//  PostUpdatableTests.swift
//  PosterrTests
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import XCTest
import Combine

@testable import Posterr

class PostUpdatableTests: XCTestCase {

    private var userRepoMock: UserRepositoryMock!
    private var postRepoMock: PostRepositoryMock!

    private var usecase: PostUpdatable!
    
    private var cancellables = [AnyCancellable]()
    
    private var successExpectation: XCTestExpectation!
    private var errorExpectation: XCTestExpectation!
    private var expectedError: PostableError?
    
    override func setUp() {
        super.setUp()
        userRepoMock = .init()
        postRepoMock = .init()
        usecase = PostUpdatableUseCase(userRepository: userRepoMock, postRepository: postRepoMock)
        usecase.didError.sink { error in
            self.expectedError = error as? PostableError
            self.errorExpectation.fulfill()
        }.store(in: &self.cancellables)
        usecase.didUpdate.sink { _ in
            self.successExpectation.fulfill()
        }.store(in: &self.cancellables)
    }
    
    func test_submitPost_whenContentExceeded_shouldReturnError() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.models = [
            makePost(user, and: longContent)
        ]
        errorExpectation = makeExpec()
        
        // Act
        self.usecase.post(with: self.longContent)
        wait(for: [errorExpectation], timeout: 3.0)
        
        // Assert
        XCTAssertTrue(expectedError == .contentExceeded)
    }
    
    func test_submitPost_whenDailyLimitExceeded_shouldReturnError() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.models = makePosts(of: 5)
        errorExpectation = makeExpec()
        
        // Act
        self.usecase.post(with: shortContent)
        wait(for: [errorExpectation], timeout: 3.0)
        
        // Assert
        XCTAssertTrue(expectedError == .dailyLimitExceeded)
    }
    
    func test_submitPost_whenThereIsNoValidationError_shouldReturnSuccess() {
        // Arrange
        let user: UserModel = makeUser()
        userRepoMock.model = user
        postRepoMock.model = makePost(user)
        postRepoMock.models = makePosts(of: 4)
        successExpectation = makeExpec()
        
        // Act
        self.usecase.post(with: shortContent)
        wait(for: [successExpectation], timeout: 3.0)
        
        // Assert
        XCTAssertEqual(userRepoMock.puttedUser?.postsCount, 1)
    }
    
    func test_submitPost_whenThereIsNoValidationError_shouldUpdateRepostReferences() {
        // Arrange
        let user: UserModel = makeUser()
        let originalPost = makePost(user)
        let post = makePost(user, source: .repost, originalPosts: [originalPost])
        successExpectation = makeExpec()
        
        userRepoMock.model = user
        postRepoMock.model = post
        postRepoMock.models = [post]
        
        // Act
        self.usecase.post(with: shortContent)
        wait(for: [successExpectation], timeout: 3.0)
        
        // Assert
        XCTAssertEqual(userRepoMock.puttedUser?.repostsCount, 1)
        XCTAssertEqual(userRepoMock.puttedUser?.repostsId.first, originalPost.uuid)
    }
    
    func test_submitPost_whenThereIsNoValidationError_shouldUpdateQuotePostingReferences() {
        // Arrange
        let user: UserModel = makeUser()
        let originalPost = makePost(user)
        let post = makePost(user, source: .quote, originalPosts: [originalPost])
        successExpectation = makeExpec()
        
        userRepoMock.model = user
        postRepoMock.model = post
        postRepoMock.models = [post]
        
        // Act
        self.usecase.post(with: shortContent)
        wait(for: [successExpectation], timeout: 3.0)
        
        // Assert
        XCTAssertEqual(userRepoMock.puttedUser?.quotePostingCount, 1)
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
    
    private func makePost(_ user: UserModel, and content: String = "test content", source: SourceType = .post, originalPosts: [PostModel] = []) -> PostModel {
        .init(uuid: UUID().uuidString, content: content, createdAt: Date(), user: user, source: source, originalPosts: originalPosts)
    }
    
    private func makeExpec() -> XCTestExpectation {
        expectation(description: "new expectation")
    }
}
