//
//  CartView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 25.10.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var cartItem: CartItems
    var product: Product?
    @State var totalPrice: Double = 0

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(Array(cartItem.cartItems.enumerated()), id: \.element.id) { index, product in
                            CartCardView(cartItem: cartItem, product: product)
                                .padding(.horizontal) // Yatayda boşluk ekliyoruz
                                .padding(.vertical, 8) // Kartlar arası dikey boşluk
                                .animation(.bouncy)
                            
                            if index != cartItem.cartItems.count - 1 {
                                Divider()
                                    .padding(.vertical, 5)
                                    .padding(.horizontal)
                            }
                        }
                        
                        // Boş alan bırakmak için Spacer ekliyoruz
                        Spacer() // Bu, butonun en altta kalmasını sağlar.
                    }
                    .padding(.bottom, 100) // ScrollView'un altında biraz boşluk bırak
                }

                // Buton her zaman en altta olacak şekilde yerleştiriyoruz
                VStack {
                    Spacer() // Butonu sayfanın en altına yerleştirir.
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
                            Text("$\(totalPrice, specifier: "%.2f")") // Toplam fiyatı göster
                                .font(.headline)
                                .padding(.trailing, 15)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 70) // Butonun boyutunu ayarlayın
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue).shadow(radius: 10)) // Arka plan
                        .padding()
                    } else {
                        CartEmptyView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Cart")
            .onAppear {
                calculateTotalPrice() // Görünüm yüklendiğinde toplam fiyatı hesapla
            }
            .onChange(of: cartItem.cartItems) { _ in
                calculateTotalPrice() // Görünüm yüklendiğinde toplam fiyatı hesapla
            }
        }
    }

    func calculateTotalPrice() {
        totalPrice = cartItem.cartItems.reduce(0) { $0 + ($1.price ?? 0.0) } // Her ürünün fiyatını topla
    }
}

struct CartCardView: View {
    @ObservedObject var cartItem: CartItems
    var product: Product?

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if let product = product {
                        WebImage(url: URL(string: product.thumbnail))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 8)

                        VStack(alignment: .leading) {
                            Text(product.title.count > 20 ? "\(product.title.prefix(14))..." : product.title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }

                        Spacer()

                        Button {
                            if let index = cartItem.cartItems.firstIndex(where: { $0.id == product.id }) {
                                cartItem.cartItems.remove(at: index)
                            }
                        } label: {
                            Image(systemName: "cart.badge.minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue).opacity(0.8)
                                .padding(.trailing, 8)
                        }
                    }
                }
                .padding(.vertical, 10) // Kart içeriği için dikeyde biraz boşluk
            }
            .padding(10) // Kartın genel kenar boşlukları
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
    CartView(cartItem: CartItems())
}
