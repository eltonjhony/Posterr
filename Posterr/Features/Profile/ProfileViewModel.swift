//
//  ProfileViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension ProfileView {
    
    class ViewModel: ObservableObject {
        
        @Published var data: ProfileInfoModel?
        
        private let repository: PostRepository
        private let usecase: PostSubmitable
        private let fetchable: ProfileInfoFetchable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostSubmitable, repository: PostRepository, fetchable: ProfileInfoFetchable) {
            self.usecase = usecase
            self.repository = repository
            self.fetchable = fetchable
            registerForUpdates()
        }
        
        func onAppear() {
            fetchable.fetchProfileData()
        }
        
        func repost(_ post: PostModel) {
            usecase.repost(post: post)
        }
        
        private func registerForUpdates() {
            usecase.didPost.sink { [weak self] _ in
                self?.fetchable.fetchProfileData()
            }.store(in: &cancellables)
            
            fetchable.data
                .assign(to: \.data, on: self)
                .store(in: &cancellables)
        }
    }
    
}
