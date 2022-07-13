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
        
        @Published var feed: FeedModel?
        
        private let usecase: PostUpdatable
        private let fetchable: FeedFetchable
        
        private var cancellables = [AnyCancellable]()
        
        init(usecase: PostUpdatable, fetchable: FeedFetchable) {
            self.usecase = usecase
            self.fetchable = fetchable
            
            registerForUpdates()
        }
        
        func onAppear() {
            fetchable.fetchMyFeed()
        }
        
        private func registerForUpdates() {
            usecase.didUpdate.sink { [weak self] _ in
                self?.fetchable.fetchMyFeed()
            }.store(in: &cancellables)
            
            fetchable.data
                .assign(to: \.feed, on: self)
                .store(in: &cancellables)
        }
        
    }
    
}
