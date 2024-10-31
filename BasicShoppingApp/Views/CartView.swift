//
//  CartView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 25.10.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
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
                                CartProductView(cart: cart, cartItem: item, showAlert: $showAlert, selectedItem: $selectedItem)
                                    .padding()
                                    .animation(.bouncy)
                            }
                        }
                        Spacer()
                        CheckoutBtn(cart: cart, totalPrice: totalPrice)
                            .padding()
                    }
                    .alert("Are You Sure?", isPresented: $showAlert) {
                        Button("Remove", role: .destructive) {
                            if let item = selectedItem, let index = cart.cartItems.firstIndex(where: { $0.id == item.id }) {
                                cart.cartItems.remove(at: index)
                            }
                        }
                        Button("No", role: .cancel) {}
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}


struct CartProductView: View {
    @ObservedObject var cart: Cart
    var cartItem: CartItem
    @Binding var showAlert: Bool
    @Binding var selectedItem: CartItem?

    var body: some View {
        HStack {
            WebImage(url: URL(string: cartItem.product.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(cartItem.product.title)
                    .frame(width: 150, alignment: .leading)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text("$\(cartItem.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()

            // Arttır/azalt butonu
            IncreaseDecreaseBtn(product: cartItem.product, cart: cart, showAlert: $showAlert, selectedItem: $selectedItem, cartItem: cartItem)
        }
        .padding(10)
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

struct CheckoutBtn: View {
    @ObservedObject var cart: Cart
    var totalPrice: Double
    var body: some View {
        if cart.cartItems.isEmpty{
            Text("blabla")
            } else {
                HStack {
                    Button {
                        print("Purchase process...")
                    } label: {
                        Text("Checkout")
                            .font(.title2)
                            .padding(.leading, 15)
                            .foregroundColor(.white)
                        Image(systemName: "arrow.forward")
                            .font(.title3)
                            .padding(.vertical, 5)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("$\(totalPrice ?? 0, specifier: "%.2f")")
                        .font(.headline)
                        .padding(.trailing, 15)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 70)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).shadow(radius: 10))
                .padding()
            }
        }
    }
