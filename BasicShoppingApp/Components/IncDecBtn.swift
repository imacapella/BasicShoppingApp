//
//  IncDecBtn.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.10.2024.
//
import SwiftUI

struct IncreaseDecreaseBtn: View{
    @State private var showAlert = false // Alert için state değişkeni
    var product: Product
    @ObservedObject var cart: Cart
    
    var body: some View {
        HStack {
            Button(action: {
                if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                    if cart.cartItems[index].quantity > 0 {
                        cart.cartItems[index].quantity -= 1
                        if cart.cartItems[index].quantity <= 0 {
                            showAlert = true // Quantity 0’a inerse alert göster
                        }
                    }
                }
            }) {
                Spacer()
                Image(systemName: "minus")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Circle().fill(Color.white).stroke(Color.black, lineWidth: 1))
            }
            .alert("Are You Sure", isPresented: $showAlert) {
                Button("Remove", role: .destructive){if let index = cart.cartItems.firstIndex(where: { $0.id == product.id }) {
                    cart.cartItems.remove(at: index)}
                }
                Button("No", role: .cancel){}
            }
            
            Text("\(cart.cartItems.first?.quantity)")
                .font(.title)
                .padding()
                .foregroundColor(.white)
            
            Button(action: {
                if let index = cart.cartItems.firstIndex(where: { $0.product.id == product.id }) {
                    cart.cartItems[index].quantity += 1
                }
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Circle().fill(Color.white).stroke(Color.black, lineWidth: 1))
            }

            
        }
        
    }
}
