//
//  DBManager.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift
import Combine

protocol DBManager {
    func save(object: Storable) throws
    func update(object: Storable) throws
    func delete(object: Storable) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> AnyPublisher<[T], Error>
}
