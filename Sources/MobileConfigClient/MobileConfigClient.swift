//
//  Untitled.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 3/10/24.
//

import ComposableArchitecture

@DependencyClient
public struct MobileConfigClient: Sendable {
    public var editorChoices: @Sendable () async throws -> [EditorChoice]
}
