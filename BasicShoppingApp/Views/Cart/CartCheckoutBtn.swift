//
//  CartCheckoutBtn.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 2.11.2024.
//
import SwiftUI

struct CheckoutBtn: View {
    var totalPrice: Double

    var body: some View {
        HStack {
            Button(action:{}) {
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
    }
}

#Preview {
    CheckoutBtn(totalPrice: 100)
}
