//
//  AddPostViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension AddPostView {
    
    class ViewModel: ObservableObject {
        
        @Published var currentUser: UserModel?
        @Published var content: String = ""
        @Published var dismiss: Bool = false
        
        private let userRepository: UserRepository
        private let usecase: PostSubmitable
        
        private var cancellables = [AnyCancellable]()
        
        init(userRepository: UserRepository, usecase: PostSubmitable) {
            self.userRepository = userRepository
            self.usecase = usecase
            
            registerForSubmitableUpdates()
        }
        
        func onAppear() {
            fetchCurrentUser()
        }
        
        func submitPost() {
            usecase.post(with: content)
        }
        
        private func fetchCurrentUser() {
            userRepository.getCurrentUser()
                .sink { _ in } receiveValue: { [weak self] model in
                    self?.currentUser = model
                }.store(in: &cancellables)
        }
        
        private func registerForSubmitableUpdates() {
            usecase.didPost.sink { [weak self] _ in
                self?.dismiss.toggle()
            }.store(in: &cancellables)
        }
        
    }
    
}
