//
//  PosterrAssembler.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

public final class PosterrAssembler {
    // MARK: - Public static

    public static var shared = PosterrAssembler()

    // MARK: - Private constants

    private let assembler = Assembler()

    // MARK: - Private read-only

    private var container: Container {
        guard let container = assembler.resolver as? Container else {
            preconditionFailure("The resolver must be an instance of Container.")
        }

        return container
    }

    // MARK: - Public

    /// Use this function to register multiple assemblies
    /// - Parameter assemblies: the assemblies list to apply to the container
    public static func apply(_ assemblies: [PosterrAssembly]) {
        assemblies.forEach { $0.assemble(container: shared.container) }
    }

    /// Use this function to register one single assembly
    /// - Parameter assembly: the assembly to apply to the container
    public static func apply(_ assembly: PosterrAssembly) {
        assembly.assemble(container: shared.container)
    }

    /// Retrieves the instance with the specified service type.
    ///
    /// - Parameter serviceType: The service type to resolve.
    /// - Returns: The resolved service type instance, or nil if no registration for the service type is found in the `Container`.
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        unwrap(shared.container.resolve(serviceType))
    }

    /// Retrieves the instance with the specified service type.
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - name: Differentiate when you have multiple registered implementations for the same protocol
    /// - Returns: The resolved service type instance, or nil if no registration for the service type is found in the `Container`.
    public static func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service {
        unwrap(shared.container.resolve(serviceType, name: name))
    }

    /// Retrieves the instance with the specified service type.
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arg1: 1 argument to pass to the factory closure.
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found in the `Container`.
    public static func resolve<Service, Arg1>(_ serviceType: Service.Type, argument arg1: Arg1) -> Service {
        unwrap(shared.container.resolve(serviceType, argument: arg1))
    }

    /// Retrieves the instance with the specified service type.
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arg1: 1 argument to pass to the factory closure.
    ///   - name: Differentiate when you have multiple registered implementations for the same protocol
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found in the `Container`.
    public static func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String, argument arg1: Arg1) -> Service {
        unwrap(shared.container.resolve(serviceType, name: name, argument: arg1))
    }

    /// Retrieves the instance with the specified service type.
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - arg1: 1 argument to pass to the factory closure.
    ///   - arg2: 2 argument to pass to the factory closure.
    /// - Returns: The resolved service type instance, or nil if no registration for the service type
    ///            and 1 argument is found in the `Container`.
    public static func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        unwrap(shared.container.resolve(serviceType, arguments: arg1, arg2))
    }

    // Retrieves the instances with the specified service type and registration names.
    /// - Parameters:
    ///   - serviceType: The service type to resolve.
    ///   - implementations: A list of concrrete implementations. Usually required for scenarios when a single `Protocol` will have multiple concrete implementations.
    /// - Returns: The resolved service type instances, or nil if no registration for the service type and names are found in the `Container`.
    public static func resolveMany<Service, Implementation>(_ serviceType: Service.Type, implementations: [Implementation]) -> [Service]? {
        let names = implementations.map { implementation in String(describing: implementation) }
        return shared.container.resolveMany(serviceType, names: names)
    }

    /// Be EXTREMLY careful using this function!!! All instances registered for all scopes will be `DISCARDED`!
    public static func reset() {
        shared.container.resetObjectScope(.container)
        shared.container.resetObjectScope(.graph)
        shared.container.resetObjectScope(.weak)
    }

    // MARK: - Private functions

    private static func unwrap<Service>(_ service: Service?) -> Service {
        guard let service = service else {
            preconditionFailure("Wasn't possible to resolve \(Service.self). Check the registration in your assembly!")
        }
        return service
    }
}
