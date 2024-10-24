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
                FavoritesCardView(favoriteItems: favoriteItems)
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
            VStack {
                ForEach(favoriteItems.favoriteProducts) { product in
                    HStack {
                        WebImage(url: product.thumbnail, width: 42, height: 42)
                            .padding(.leading)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.title2)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.title3)
                        }
                        Spacer() // Boşluk bırakmak için
                        Button(){
                            if let index = favoriteItems.favoriteProducts.firstIndex(where: {$0.id == product.id }){
                                favoriteItems.favoriteProducts.remove(at: index)
                            }
                        } label:{
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19, height: 19)
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            .frame(height: 55)
                    ).padding()
                    
                }
            }
        }
    }
}
