//
//  CartView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 25.10.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @State var showAlert: Bool = false
    @ObservedObject var cart: Cart
    private var totalPrice: Double {
        cart.cartItems.reduce(0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
            ZStack {
                    VStack(spacing: 0) {
                        ForEach(cart.cartItems) { item in
                            CartCardView(cart: cart, cartItem: item)
                                .padding(.horizontal)
                                .animation(.bouncy)
                                .alert("Are You Sure", isPresented: $showAlert) {
                                    Button("Remove", role: .destructive){
                                        if let index = cart.cartItems.firstIndex(where: { $0.id == item.id }) {
                                            cart.cartItems.remove(at: index)
                                        }
                                    }
                                    Button("No", role: .cancel){}
                                }
                            DivideProducts(cart: cart, item: item)
                        }
                        Spacer()
                        HStack(alignment: .bottom){
                            CheckoutBtn(totalPrice: totalPrice)
                        }
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}

struct CartCardView: View {
    @ObservedObject var cart: Cart
    var cartItem: CartItem

    var body: some View {
        HStack {
            WebImage(url: URL(string: cartItem.product.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(cartItem.product.title.count > 20 ? "\(cartItem.product.title.prefix(14))..." : cartItem.product.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text("$\(cartItem.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            //Spacer()

            // Arttır/azalt butonu
            IncreaseDecreaseBtn(product: cartItem.product, cart: cart)
        }
        .padding(10) // Tüm kart için tek bir padding
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
    var totalPrice: Double
    var body: some View {
            if totalPrice != 0 {
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
            } else {
                Text("blabla")
            }
        }
    }
