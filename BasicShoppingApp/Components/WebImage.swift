//
//  WebImage.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 23.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageManuel: View {
    var url: String
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        
        AsyncImage(url: URL(string: url)){ image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
        } placeholder:{
            ProgressView()
        }
    }
}

