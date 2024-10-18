//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dao = ProductsDao()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<dao.products.count / 2, id: \.self) { row in
                    HStack {
                        ForEach(0..<2) { column in
                            let productIndex = row * 2 + column
                            if productIndex < dao.products.count {
                                Spacer()
                                ProductCardView(product: dao.products[productIndex])
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .onAppear {
            dao.fetchData()
        }
    }
}


#Preview {
    ContentView()
    
}

struct ProductCardView: View {
    @State var isFavorite: Bool = false
    let product: Product  // Product nesnesi parametre olarak alınıyor
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .animation(.easeIn(duration: 0.2))
                .padding()
            }
            
            Spacer()
            
            // Ürün görseli
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                // Ürün adı
                Text(product.title)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                // Ürün açıklaması
                Text("dadawdwadd")
                    .font(.title3)
                    .padding(.horizontal)
            }
            
            HStack {
                // Ürün fiyatı
                Text("$\(product.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                
                Spacer()
                
                // Ürün değerlendirmesi
                Text("⭐ \(String(format: "%.1f", product.rating))")
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 15)
        )
        .frame(width: 170, height: 200)
        .padding()
    }
}


