//
//  ProductCardView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 22.10.2024.
//

import SwiftUI

struct ProductCardView: View {
    @Binding var product: Product// Product nesnesi parametre olarak alınıyor
    @ObservedObject var favoriteItems: FavoritedProducts
    @State var isFavorite: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isFavorite.toggle()
                    if isFavorite {
                        // Favori listesine ekle
                        self.favoriteItems.favoriteProducts.append(product)
                    } else {
                        
                        // Favori listesinden çıkar (Bu kısmı tam çözemedim hayırlısı diyelim allah büyük)
                        if let index = self.favoriteItems.favoriteProducts.firstIndex(where: { $0.id == product.id }) {
                            self.favoriteItems.favoriteProducts.remove(at: index)
                        }
                    }
                      // Favori durumunu değiştir
                    print(product.title, isFavorite, favoriteItems.favoriteProducts)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .animation(.easeIn(duration: 0.1))
                .padding()
            }
            
            //Spacer()
            
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
        
       /* .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 15)
        )
        .frame(width: 170, height: 200)
        //.padding()*/
    }
}

