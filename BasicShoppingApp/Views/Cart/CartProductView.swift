//
//  CartProductView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 2.11.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartProductView: View {
    @ObservedObject var viewModel : CartViewModel
    var cartItem: CartItem

    var body: some View {
        HStack {
            WebImage(url: URL(string: cartItem.product.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.horizontal, 5)

            VStack(alignment: .leading) {
                Text(cartItem.product.title)
                    .frame(width: 130, alignment: .center)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text("$\(cartItem.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()

            HStack{
                Button{viewModel.decreaseQuantity(for: cartItem)}
                label: {
                    Image("minus-square")
                        .frame(width: 25, height: 25)
                }
                Text("\(cartItem.product.price)")
                    .font(.title3)
                    .fontWeight(.semibold)
                Button{viewModel.increaseQuantity(for: cartItem)}
                label: {
                    Image("add-square")
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding(10)
    }
}
