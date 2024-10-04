//
//  DependencyValues.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 4/10/24.
//

import ComposableArchitecture

extension DependencyValues {
    public var mobileConfigClient: MobileConfigClient {
        get { self[MobileConfigClient.self] }
        set { self[MobileConfigClient.self] = newValue }
    }
}
