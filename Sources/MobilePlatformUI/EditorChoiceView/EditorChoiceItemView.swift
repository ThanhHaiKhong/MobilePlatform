//
//  MobilePlatformUI.swift
//  MobilePlatform
//
//  Created by Thanh Hai Khong on 3/10/24.
//

import ComposableArchitecture
import MobileConfigClient
import Kingfisher
import SwiftUI

public struct EditorChoiceItemView: View {
    
    let store: StoreOf<EditorChoiceItem>
    
    private let edgePadding: CGFloat = 12
    private let artworkSize: CGFloat = 40
    
    public init(store: StoreOf<EditorChoiceItem>) {
        self.store = store
    }

    public var body: some View {
        KFImage(store.item.artworkURL)
            .resizable()
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .placeholder {
                ProgressView()
                    .padding(.bottom, 32)
            }
            .aspectRatio(1.4, contentMode: .fit)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
            .contentShape(Rectangle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: artworkSize + edgePadding * 2)
                    .overlay {
                        HStack {
                            KFImage(store.item.miniIconURL)
                                .resizable()
                                .loadDiskFileSynchronously()
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: artworkSize, height: artworkSize)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(store.item.caption ?? "")
                                    .font(.subheadline)
                                    .lineLimit(1)
                                
                                Text(store.item.description ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            Button {
                                if let url = store.item.appStoreURL {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Text("FREE")
                                    .font(.system(.footnote, design: .monospaced).weight(.bold))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, edgePadding)
                                    .background(.blue, in: Capsule())
                            }
                        }
                        .padding(.horizontal, edgePadding)
                    }
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            .onTapGesture {
                if let url = store.item.appStoreURL {
                    UIApplication.shared.open(url)
                }
            }
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
