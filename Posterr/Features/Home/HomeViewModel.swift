//
//  HomeViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension HomeView {
    
    class ViewModel: ObservableObject, Alertable {
        
        @Published var alert: NotificationDataModel = ToastDataModel.unknown
        @Published var isAlertShown: Bool = false
        
        @Published var posts: [PostModel] = []
        @Published var currentUser: UserModel?
        
        private let repository: PostRepository
        private let usecase: PostUpdatable
        private let userRegistrable: UserRegistrable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostUpdatable, repository: PostRepository, userRegistrable: UserRegistrable) {
            self.usecase = usecase
            self.repository = repository
            self.userRegistrable = userRegistrable
            
            registerForUpdates()
        }
        
        func onAppear() {
            fetchPosts()
        }
        
        private func fetchPosts() {
            repository.getAllPosts()
                .sink { [weak self] in
                    if case let .failure(error) = $0 {
                        self?.toastError(error)
                    }
                } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }.store(in: &cancellables)
        }
        
        private func registerForUpdates() {
            usecase.didUpdate.sink { [weak self] _ in
                self?.fetchPosts()
            }.store(in: &cancellables)
            
            userRegistrable.didChangeUser
                .assign(to: \.currentUser, on: self)
                .store(in: &cancellables)
        }
        
    }
    
}
