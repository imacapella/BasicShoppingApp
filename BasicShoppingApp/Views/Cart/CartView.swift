//
//  CartView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 25.10.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var viewModel : CartViewModel
    @State private var showAlert: Bool = false
    @State private var selectedItem: CartItem?  // Hangi ürünün silineceğini belirlemek için
    @ObservedObject var cart: Cart
    private var totalPrice: Double {
        cart.cartItems.reduce(0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if cart.cartItems.isEmpty {
                    CartEmptyView()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(cart.cartItems) { item in
                                CartProductView(cartItem: cart.cartItems[item])
                                DivideProducts(cart: cart, item: item)
                            }
                            Spacer()
                            CheckoutBtn(cart: cart, totalPrice: totalPrice)
                                .padding()
                        }   
                    }
                    .alert("Are You Sure?", isPresented: $showAlert) {
                        Button("Remove", role: .destructive) {
                            viewModel.removeFromCart()
                        }
                        Button("No", role: .cancel) {}
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}

struct CartEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "cart.fill.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            Text("Cart is Empty")
                .font(.headline)

            Text("Add more goods to your cart!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

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


