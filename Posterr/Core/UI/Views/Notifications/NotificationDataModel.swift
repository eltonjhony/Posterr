//
//  NotificationDataModel.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation

protocol NotificationDataModel {
    var message: String { get }
    var image: String { get }
    var onCancel: (() -> Void)? { get }

    static var unknown: NotificationDataModel { get }
}

extension NotificationDataModel {
    static var unknown: NotificationDataModel {
        ToastDataModel("An Unexpected Error Occurred")
    }
}

struct ToastDataModel: NotificationDataModel {
    let message: String
    let image: String
    let onCancel: (() -> Void)? = nil

    init(_ message: String, image: String = "warningIcon") {
        self.message = message
        self.image = image
    }
}
