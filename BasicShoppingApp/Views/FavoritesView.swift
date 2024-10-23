//
//  FavoritesView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 22.10.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoriteItems: FavoritedProducts
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack { // HStack yerine VStack, çünkü ürünleri dikey listelemek daha yaygın bir kullanım
                    ForEach(favoriteItems.favoriteProducts) { product in
                        HStack {
                            Text(product.title) // Ürün başlığını göster
                            Spacer() // Boşluk bırakmak için
                            Text("$\(product.price, specifier: "%.2f")") // Ürün fiyatını göster
                        }
                        .padding()
                    }
                }
            }.onAppear{
                print(favoriteItems.favoriteProducts)
            }
            .navigationTitle("Favorites")
        }
    }
}


#Preview {
    // Favoriler için örnek oluşturuyoruz.
    FavoritesView(favoriteItems: FavoritedProducts())
}

struct FavoritesCardView: View {
    @ObservedObject var favoriteItems: FavoritedProducts // Dışarıdan FavoritedProducts alıyoruz
    
    var body: some View {
        ZStack {
            
        }
    }
}
