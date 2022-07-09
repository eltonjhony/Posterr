//
//  MappableProtocol.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift

//MARK: - MappableProtocol
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}
