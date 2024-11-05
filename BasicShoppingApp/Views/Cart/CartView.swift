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
                    Spacer()
                    EmptyInfoView(icon: "cart.fill.badge.plus", headline: "Cart is Empty", desc: "Add more goods to your cart!")
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(cart.cartItems) { item in
                                CartProductView(
                                    onIncreased: { viewModel.increaseQuantity(for: item) },
                                    onDecreased: { viewModel.decreaseQuantity(for: item) },
                                    onRemove: { viewModel.removeFromCart() },
                                    cartItem: item
                                )
                                .animation(.bouncy)
                                
                                DivideProducts(cart: cart, item: item)
                            }
                        }
                    }
                    
                    Spacer() // Checkout butonunun üstünde boşluk bırakır ve en alta iter
                    
                    CheckoutBtn(totalPrice: totalPrice)
                        .padding()
                        .shadow(radius: 5)
                }
            }
            .navigationTitle("Cart")
            .alert("Are You Sure?", isPresented: $viewModel.showAlert) {
                Button("Remove", role: .destructive) {
                    viewModel.removeFromCart()
                }
                Button("No", role: .cancel) {}
            }
        }
    }
}
