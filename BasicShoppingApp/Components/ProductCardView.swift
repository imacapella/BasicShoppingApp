//
//  ProductCardView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 22.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCardView: View {
    var product: Product// Product nesnesi parametre olarak alınıyor
    @ObservedObject var favoriteItems: FavoritedProducts
    @ObservedObject var cartItems: Cart
    @State var isFavorite: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Text("⭐ \(String(format: "%.1f", product.rating))")
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Spacer()
                    Button {
                        
                        isFavorite.toggle()
                        if isFavorite {
                            self.favoriteItems.favoriteProducts.append(product)
                        } else {
                            if let index = self.favoriteItems.favoriteProducts.firstIndex(where: { $0.id == product.id }) {
                                self.favoriteItems.favoriteProducts.remove(at: index)
                            }
                        }
                        // Favori durumunu değiştir
                        print(product.title, isFavorite, favoriteItems.favoriteProducts)
                    } label: {
                        Image(systemName: isFavorite(product: product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                    .animation(.easeIn(duration: 0.1))
                    .padding()
                }
            }
            
            //Spacer()
            
            // Ürün görseli
            NavigationLink(destination: ProductDetailView(product: product, cart: cartItems)) {
                WebImage(url: URL(string: product.thumbnail))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                // Ürün adı
                NavigationLink(destination: ProductDetailView(product: product, cart: cartItems)) {
                    Text(product.title)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.black)
                        .padding(.horizontal)
                }
                // Ürün açıklaması
                Text("dadawdwadd")
                    .font(.title3)
                    .padding(.horizontal)
            }
            
            HStack {
                // Ürün fiyatı
                Text("$\(product.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                    .padding(.leading)
                Spacer()
                
                // Ürün değerlendirmesi
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) { // .easeInOut ile geçiş animasyonu
                        if let index = cartItems.cartItems.firstIndex(where: { $0.id == product.id }) {
                            cartItems.cartItems.remove(at: index)
                            print("Ürün sepetten çıkarıldı.")
                        } else {
                            cartItems.cartItems.append(product)
                            print("Ürün sepete eklendi.")
                        }
                    }
                } label: {
                        Image(systemName: isInCart(product: product) ? "trash" : "cart.badge.plus")
                        .foregroundColor(.primary)
                            .font(.title3)
                            .bold()
                    }
                    .padding(.trailing)
            }
            .padding()
        }
        
       /* .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 15)
        )
        .frame(width: 170, height: 200)
        //.padding()*/
    }
    
    func isFavorite(product: Product) -> Bool {
        return favoriteItems.favoriteProducts.contains(where: { $0.id == product.id })
    }
    
    func isInCart(product: Product) -> Bool {
        return cartItems.cartItems.contains(where: { $0.id == product.id })
    }

    
}

#Preview {
    // Burada bir Product nesnesi oluşturmalısınız
    let sampleProduct = Product(id: 1, title: "Sample Product", price: 19.99, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png", rating: 3.3, warrantyInformation: "3 weeks", shippingInformation: "Free Shipping", availabilityStatus: "In Stock")
    ProductCardView(product: sampleProduct, favoriteItems: FavoritedProducts(), cartItems: Cart())
}

