//
//  EditorChoiceItem.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 4/10/24.
//

import ComposableArchitecture
import MobileConfigClient
import SwiftUI

@Reducer
public struct EditorChoiceItem {
    @ObservableState
    public struct State: Equatable {
        public let item: EditorChoice
        
        public init(item: EditorChoice) {
            self.item = item
        }
    }
    
    public enum Action {
        
    }
}
