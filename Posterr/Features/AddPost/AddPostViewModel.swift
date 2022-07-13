//
//  AddPostViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension AddPostView {
    
    class ViewModel: ObservableObject, Alertable {
        
        @Published var alert: NotificationDataModel = ToastDataModel.unknown
        @Published var isAlertShown: Bool = false
        
        @Published var currentUser: UserModel?
        @Published var content: String = ""
        @Published var dismiss: Bool = false
        
        private let type: SubmissionType
        private let userRepository: UserRepository
        private let usecase: PostUpdatable
        
        private var cancellables = [AnyCancellable]()
        
        var originalPost: PostModel? {
            guard case let .quote(post) = type else {
                return nil
            }
            return post
        }
        
        var characterLimit: Int {
            PostLimit.content.rawValue
        }
        
        var placeholderText: String {
            originalPost == nil ? "What's happening" : "Add a comment"
        }
        
        init(type: SubmissionType, userRepository: UserRepository, usecase: PostUpdatable) {
            self.type = type
            self.userRepository = userRepository
            self.usecase = usecase
            
            registerForSubmitableUpdates()
        }
        
        func onAppear() {
            fetchCurrentUser()
        }
        
        func submitPost() {
            guard let originalPost = originalPost else {
                usecase.post(with: content)
                return
            }
            usecase.quote(of: originalPost, with: content)
        }
        
        private func fetchCurrentUser() {
            userRepository.getCurrentUser()
                .sink { [weak self] in
                    if case let .failure(error) = $0 {
                        self?.toastError(error)
                    }
                } receiveValue: { [weak self] model in
                    self?.currentUser = model
                }.store(in: &cancellables)
        }
        
        private func registerForSubmitableUpdates() {
            usecase.didUpdate.sink { [weak self] _ in
                self?.dismiss.toggle()
            }.store(in: &cancellables)
            
            usecase.didError.sink { [weak self] error in
                self?.toastError(error)
            }.store(in: &cancellables)
        }
        
    }
    
}
