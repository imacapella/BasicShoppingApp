//
//  CartView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 25.10.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var cart: Cart
    var product: Product?
    @State var totalPrice: Double = 0

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(cart.cartItems) { item in
                            CartCardView(cartItem: item, cart: cart)
                                //.padding(.horizontal)
                                //.padding(.vertical, 8)
                                //.animation(.bouncy)
                            
                            if cart.cartItems.last?.id != item.id {
                                Divider()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 100)
                }

                VStack {
                    Spacer()
                    if totalPrice != 0 {
                        HStack(alignment:.bottom) {
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
                            Text("$\(totalPrice, specifier: "%.2f")")
                                .font(.headline)
                                .padding(.trailing, 15)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 70)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).shadow(radius: 10))
                        .padding()
                    } else {
                        CartEmptyView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Cart")
            .onAppear {
                calculateTotalPrice()
            }
            .onChange(of: cart.cartItems) { _ in
                calculateTotalPrice()
            }
        }
    }

    func calculateTotalPrice() {
        totalPrice = cart.cartItems.reduce(0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
    }
}

struct CartCardView: View {
    var cartItem: CartItems
    @ObservedObject var cart: Cart

    var body: some View {
        ZStack {
            VStack {
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
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("$\(cartItem.product.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    IncreaseDecreaseBtn(cartItem: cartItem, cart: cart)
                }
                .padding(.vertical, 10)
            }
            .padding(10)
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

#Preview {
    CartView(cart: Cart())
}
