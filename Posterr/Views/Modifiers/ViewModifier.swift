//
//  ViewModifier.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

// MARK: - Style

struct StyleModifier<T: ViewModifier> {
    let modifier: T
}

extension View {
    func style<T: ViewModifier>(_ viewModifier: StyleModifier<T>) -> some View {
        modifier(viewModifier.modifier)
    }
}

// MARK: - Layout

struct LayoutModifier<T: ViewModifier> {
    let modifier: T
}

extension View {
    func layout<T: ViewModifier>(_ viewModifier: LayoutModifier<T>) -> some View {
        modifier(viewModifier.modifier)
    }
}

// MARK: - Behaviour

struct BehaviorModifier<T: ViewModifier> {
    let modifier: T
}

extension View {
    func behaviour<T: ViewModifier>(_ viewModifier: BehaviorModifier<T>) -> some View {
        modifier(viewModifier.modifier)
    }
}

// MARK: - Animation

struct AnimationModifier<T: ViewModifier> {
    let modifier: T
}

extension View {
    func animate<T: ViewModifier>(_ viewModifier: AnimationModifier<T>) -> some View {
        modifier(viewModifier.modifier)
    }
}
