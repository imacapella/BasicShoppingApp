//
//  FavoritesViewModel.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 1.11.2024.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteProducts: FavoritedProducts
    
    init(favoriteProducts: FavoritedProducts) {
        self.favoriteProducts = favoriteProducts
    }
    
    func removeFromFavorites(product: Product) {
        if let index = favoriteProducts.favoriteProducts.firstIndex(where: { $0.id == product.id }) {
            favoriteProducts.favoriteProducts.remove(at: index)
        }
    }
}

