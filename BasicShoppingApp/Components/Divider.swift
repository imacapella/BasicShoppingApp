//
//  Divider.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 3.11.2024.
//

import SwiftUI

struct DivideProducts : View {
    @ObservedObject var cart: Cart
    var item: CartItem
    var body: some View {
        if cart.cartItems.last?.id != item.id {
            Divider()
                .padding(.vertical, 5)
        }
    }
}
