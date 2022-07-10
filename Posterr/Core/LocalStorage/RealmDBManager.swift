//
//  RealmDBManager.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift
import Combine

enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
}

final class RealmDBManager: DBManager {
    
    //MARK: - Stored Properties
    private let realm: Realm?
    
    init(_ realm: Realm?) {
        self.realm = realm
    }
    
    //MARK: - Public Methods
    
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func update(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.add(object,update: .all)
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> AnyPublisher<[T], Error> where T : Storable {
        Future { [weak self] promisse in
            guard let realm = self?.realm, let model = model as? Object.Type else {
                promisse(.failure(RealmError.eitherRealmIsNilOrNotRealmSpecificModel))
                return
            }
            var objects = realm.objects(model)
            if let predicate = predicate {
                objects = objects.filter(predicate)
            }
            if let sorted = sorted {
                objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
            }
            promisse(.success(objects.compactMap { $0 as? T }))
        }.eraseToAnyPublisher()
    }
    
}
