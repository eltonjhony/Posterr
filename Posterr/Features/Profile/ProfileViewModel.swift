//
//  ProfileViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Combine

extension ProfileView {
    
    class ViewModel: ObservableObject, Alertable {
        
        @Published var alert: NotificationDataModel = ToastDataModel.unknown
        @Published var isAlertShown: Bool = false
        
        @Published var data: ProfileInfoModel?
        
        private let repository: PostRepository
        private let usecase: PostUpdatable
        private let fetchable: ProfileInfoFetchable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostUpdatable, repository: PostRepository, fetchable: ProfileInfoFetchable) {
            self.usecase = usecase
            self.repository = repository
            self.fetchable = fetchable
            registerForUpdates()
        }
        
        func onAppear() {
            fetchable.fetchProfileData()
        }
        
        private func registerForUpdates() {
            usecase.didUpdate.sink { [weak self] _ in
                self?.fetchable.fetchProfileData()
            }.store(in: &cancellables)
            
            fetchable.didError.sink { [weak self] error in
                self?.toastError(error)
            }.store(in: &cancellables)
            
            fetchable.data
                .assign(to: \.data, on: self)
                .store(in: &cancellables)
        }
    }
    
}
