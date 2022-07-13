//
//  ProfileInfoModel.swift
//  Posterr
//
//  Created by Elton Jhony on 10.07.22.
//

import Foundation

public struct ProfileInfoModel {
    let currentUser: UserModel
    let posts: [PostModel]
    
    var joinerDate: String {
        currentUser.createdAt.format(with: .MMMMddyyyy)
    }
}
