import SwiftUI
import SDWebImageSwiftUI

struct ProductCardView: View {
    var product: Product
    @ObservedObject var favoriteItems: FavoritedProducts
    @ObservedObject var cart: Cart
    @State var isFavorite: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .opacity(0.8)
                    Text("\(String(format: "%.1f", product.rating))")
                        .fontWeight(.semibold)
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
                    } label: {
                        Image(systemName: isFavorite(product: product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal) // HStack için yatay padding
            }
            
            // Ürün görseli
            NavigationLink(destination: ProductDetailView(product: product, cart: cart)) {
                WebImage(url: URL(string: product.thumbnail))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                NavigationLink(destination: ProductDetailView(product: product, cart: cart)) {
                    Text(product.title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                Text("Product Description")
                    .font(.footnote)
                    .padding(.horizontal)
            }
            
            HStack {
                Text("$\(product.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                            cart.cartItems.remove(at: index)
                            print("Ürün sepetten çıkarıldı.")
                        } else {
                            let newCartItem = CartItem(id: product.id, product: product, quantity: 1)
                            cart.cartItems.append(newCartItem)
                            print("Ürün sepete eklendi.")
                        }
                    }
                } label: {
                    Image(systemName: isInCart(product: product) ? "trash" : "cart.badge.plus")
                        .foregroundColor(.primary)
                        .font(.title3)
                        .bold()
                }
            }
            .padding(.horizontal)
            .padding(.top, 5) // Üstten biraz boşluk ekledik
            
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 5)
        )
        .frame(width: 170, height: 250)
    }
    
    func isFavorite(product: Product) -> Bool {
        return favoriteItems.favoriteProducts.contains(where: { $0.id == product.id })
    }
    
    func isInCart(product: Product) -> Bool {
        return cart.cartItems.contains(where: { $0.id == product.id })
    }
}

#Preview {
    let sampleProduct = Product(
        id: 1,
        title: "Sample Product",
        price: 19.99,
        thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png",
        rating: 3.3,
        warrantyInformation: "3 weeks",
        shippingInformation: "Free Shipping",
        availabilityStatus: "In Stock"
    )
    
    ProductCardView(product: sampleProduct, favoriteItems: FavoritedProducts(), cart: Cart())
}
