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
        
        private let userRepository: UserRepository
        
        private var cancellables = [AnyCancellable]()
        
        init(userRepository: UserRepository) {
            self.userRepository = userRepository
        }
        
        func onAppear() {
            fetchCurrentUser()
        }
        
        func submitPost() {
            
        }
        
        private func fetchCurrentUser() {
            userRepository.getCurrentUser()
                .sink {
                    if case let .failure(error) = $0 {
                        //TODO: Handle error
                        debugPrint(error)
                    }
                } receiveValue: { [weak self] model in
                    self?.currentUser = model
                }.store(in: &cancellables)
        }
        
    }
    
}
