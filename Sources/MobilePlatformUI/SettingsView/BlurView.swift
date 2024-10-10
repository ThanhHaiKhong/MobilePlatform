//
//  BlurView.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 10/10/24.
//

import SwiftUI

public struct BlurView: UIViewRepresentable {
    private let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .prominent) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
