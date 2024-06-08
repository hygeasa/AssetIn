//
//  AvatarPlaceholder.swift
//  AssetIn
//
//  Created by Irham Naufal on 08/06/24.
//

import SwiftUI

struct AvatarPlaceholder: View {
    
    private let url: String?
    private let width: CGFloat?
    private let height: CGFloat?
    
    init(url: String?, width: CGFloat? = 50, height: CGFloat? = 50) {
        self.url = url
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Group {
            if let imageURL = url {
                AsyncImage(url: .imagePath(imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    }
                }
            } else {
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: width, height: height)
        .clipShape(Circle())
    }
}
