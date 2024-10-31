//
//  IncDecBtn.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.10.2024.
//
import SwiftUI

struct IncreaseDecreaseBtn: View {
    var product: Product
    @ObservedObject var cart: Cart
    @Binding var showAlert: Bool
    @Binding var selectedItem: CartItem?
    var cartItem: CartItem  // Eklenen cartItem

    var body: some View {
        HStack {
            Button(action: {
                if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                    if cart.cartItems[index].quantity > 0 {
                        if cart.cartItems[index].quantity - 1 == 0 {
                            selectedItem = cartItem // Silinmek üzere seçilen öğeyi belirtiyoruz
                            showAlert = true       // alert'i tetikliyoruz
                        } else {
                            cart.cartItems[index].quantity -= 1
                        }
                    }
                }
            }) {
                Spacer()
                Image("minus-square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(10)
                    .foregroundColor(.white)
            }
            
            if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                Text("\(cart.cartItems[index].quantity)")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
            }
            Button(action: {
                if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                    cart.cartItems[index].quantity += 1
                }
            }) {
                Image("add-square")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(10)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}
