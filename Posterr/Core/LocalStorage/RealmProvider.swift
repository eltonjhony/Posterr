//
//  RealmProvider.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift

//MARK: - RealmProvider
struct RealmProvider {
    
    //MARK: - Stored Properties
    let configuration: Realm.Configuration
    
    //MARK: - Init
    internal init(config: Realm.Configuration) {
        configuration = config
    }
    
    //MARK: - Init
    private var realm: Realm? {
        do {
            let realm = try Realm(configuration: configuration)
            print("User Realm User file location: \(realm.configuration.fileURL!.path)")
            return realm
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Configuration
    private static let defaultConfig = Realm.Configuration(schemaVersion: 1)
    
    //MARK: - Realm Instances
    public static var `default`: Realm? = {
        return RealmProvider(config: RealmProvider.defaultConfig).realm
    }()
}
