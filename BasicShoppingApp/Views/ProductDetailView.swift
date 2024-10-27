//
//  ProductDetailView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 26.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    var product: Product
    @ObservedObject var cart: CartItems

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Ürün görseli
            HStack {
                Spacer()
                WebImage(url: URL(string: product.thumbnail))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 185) // Sabit genişlik ve yükseklik
                Spacer()
            }
            
            // Ürün başlığı
            Text(product.title)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            // Fiyat ve indirim bilgisi
            HStack {
                Text("$\(product.price, specifier: "%.0f")")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 4)
                    .padding(.leading)
                
                Image(systemName: "flame.fill")
                    .resizable()
                    .foregroundColor(.orange)
                    .frame(width: 25, height: 30)
                    .padding(6)
                    .cornerRadius(8)
                
                Text("Extra 5% off")
                    .font(.subheadline)
                    .padding(6)
                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // Stok ve teslimat bilgisi
            HStack(spacing: 16) { // Kutucuklar arasındaki boşluk
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.green)
                        Text("In stock")
                            .bold()
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("Delivery:")
                        Text(product.shippingInformation)
                            .bold()
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .frame(width: 200, height: 100) // Sabit genişlik ve yükseklik
                
                // Değerlendirme kutucuğu
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.8")
                            .bold()
                    }
                    Divider()
                    Text("25 reviews")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .frame(width: 120, height: 100) // Sabit genişlik ve yükseklik
            }
            .padding(.horizontal)
            
            // Sepete ekleme veya ürün miktarını artırma/azaltma düğmeleri
            if cart.cartItems.contains(product) {
                Button(action: { cart.cartItems.append(product) }) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                            .foregroundColor(.white)
                            .font(.title3)
                        Text("Add To Cart")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                    .frame(maxWidth: .infinity)
                }
                .padding()
            } else {
                HStack {
                    Button(action: {
                        if cart.quantity >= 0 {
                            cart.quantity += 1
                        }
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .background(Circle().fill(Color.white).stroke(Color.black, lineWidth: 1))
                    }
                    
                    Text("\(cart.quantity)")
                        .font(.headline)
                    
                    Button(action: {
                        if cart.quantity > 0 {
                            cart.quantity -= 1
                        }
                    }) {
                        Image(systemName: "minus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .background(Circle().fill(Color.white).stroke(Color.black, lineWidth: 1))
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ProductDetailView(product: .init(id: 1, title: "Red Lipstick", price: 100, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png", rating: 4.5, warrantInformation: "3 Weeks", shippingInformation: "Tomorrow", availabilityStatus: "In Stock"), cart: CartItems())
}
