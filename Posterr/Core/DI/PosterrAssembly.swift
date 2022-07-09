//
//  PosterrAssembly.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Swinject

public protocol PosterrAssembly {
    /// Provide hook for `Assembler` to load Services into the provided container
    ///
    /// - parameter container: the container provided by the `Assembler`
    ///
    func assemble(container: PosterrContainer)
}
