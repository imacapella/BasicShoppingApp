//
//  CartViewModel.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 1.11.2024.
//

import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    @Published var cart: Cart
    @Published var showAlert: Bool = false
    @Published var selectedItem: CartItem?  // Hangi ürünün silineceğini belirlemek için

    init(cart: Cart) {
        self.cart = cart
    }
    
    
    var totalPrice: Double {
        cart.cartItems.reduce(0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
    }

    func decreaseQuantity(for item: CartItem) {
        if let index = cart.cartItems.firstIndex(where: { $0.id == item.id }) {
            if cart.cartItems[index].quantity > 1 {
                cart.cartItems[index].quantity -= 1
            } else {
                selectItemToRemove(item)
            }
        }
    }

    func increaseQuantity(for item: CartItem) {
        if let index = cart.cartItems.firstIndex(where: { $0.id == item.id }) {
            cart.cartItems[index].quantity += 1
        }
    }


    func selectItemToRemove(_ item: CartItem) {
        selectedItem = item
        showAlert = true
    }
    
    func removeFromCart() {
        if let item = selectedItem, let index = cart.cartItems.firstIndex(where: { $0.id == item.id }) {
            cart.cartItems.remove(at: index)
            selectedItem = nil
            showAlert = false
        }
    }

    func checkout() {
        // Satın alma işlemini başlatma
        print("Purchase process...")
    }
}
