//
//  TestMobileConfigClient.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 4/10/24.
//

import Dependencies

extension MobileConfigClient: TestDependencyKey {
    public static var testValue: MobileConfigClient {
        MobileConfigClient()
    }
}
