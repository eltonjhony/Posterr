//
//  DebugViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 11.07.22.
//

import SwiftUI
import Combine

extension DebugView {
    
    class ViewModel: ObservableObject {
        
        @Published private(set) var users: [UserModel] = []
        @Published var dismiss: Bool = false
        
        private let userRepository: UserRepository
        private let usecase: UserRegistrable
        
        private var cancellables = [AnyCancellable]()
        
        init(userRepository: UserRepository, usecase: UserRegistrable) {
            self.userRepository = userRepository
            self.usecase = usecase
            
            registerForUserUpdates()
        }
        
        func onAppear() {
            userRepository.getAllUsers()
                .sink { _ in } receiveValue: { [weak self] users in
                    self?.users = users
                }
                .store(in: &cancellables)
        }
        
        func select(new user: UserModel) {
            usecase.changeCurrentUser(with: user)
        }
        
        private func registerForUserUpdates() {
            usecase.didChangeUser.sink { [weak self] _ in
                self?.dismiss.toggle()
            }.store(in: &cancellables)
        }
        
    }
    
}
