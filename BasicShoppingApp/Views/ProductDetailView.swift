//
//  ProductDetailView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 26.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    var product: Product
    @ObservedObject var cart: AddToCard
    var body: some View{
        GeometryReader { geometry in
            VStack(alignment: .center){
                WebImage(url: URL(string: product.thumbnail ))
                    .resizable()
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.4)
                    .padding(.leading)
            }
        }
    }
}

#Preview {
    ProductDetailView(product: .init(id: 1, title: "Product Title", price: 100, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Eyeshadow%20Palette%20with%20Mirror/thumbnail.png", rating: 4.5), cart: AddToCard())
}
