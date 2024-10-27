

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    var product: Product
    @ObservedObject var cart: CartItems

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    WebImage(url: URL(string: product.thumbnail))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.47)
                    Spacer()
                }
                
                Text(product.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
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
                            Text(product.shippingInformation)
                                .bold()
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 0.15)
                    
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
                    .frame(width: geometry.size.width * 0.30, height: geometry.size.height * 0.15)
                }
                .padding(.horizontal)
                
                if cart.cartItems.contains(product) {
                    IncreaseDecreaseBtn(product: product, cart: cart)
                    
                } else {
                    Button(action: { cart.cartItems.append(product); cart.quantity+=1 }) {
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
                }
            }
        }
    }
}

#Preview {
    ProductDetailView(product: .init(id: 1, title: "Red Lipstick", price: 100, thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/thumbnail.png", rating: 4.5, warrantyInformation: "3 Weeks", shippingInformation: "Tomorrow", availabilityStatus: "In Stock"), cart: CartItems())
}
