//
//  Alertable.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import SwiftUI

protocol Alertable: AnyObject {
    var alert: NotificationDataModel { get set }
    var isAlertShown: Bool { get set }

    func toast(with error: Error)
}

extension Alertable {
    
    func toast(with error: Error) {
        guard let error = error as? PostableError else {
            alert = ToastDataModel.unknown
            isAlertShown = true
            return
        }
        switch error {
        case .dailyLimitExceeded:
            alert = ToastDataModel("Daily posting limit exceeded", image: "warningIcon")
            isAlertShown = true
        case .contentExceeded:
            alert = ToastDataModel("Character posting limit exceeded", image: "warningIcon")
            isAlertShown = true
        }
    }
    
}
