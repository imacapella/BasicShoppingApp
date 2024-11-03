//
//  CartProductView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 2.11.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct CartProductView: View {
    var onIncreased: (() -> Void)?
    var onDecreased: (() -> Void)?
    var onRemove: (() -> Void)?
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
                Button(action: {
                    onDecreased?()
                }) {
                    Image("minus-square")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("\(cartItem.quantity)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 40)
                Button(action: {
                    onIncreased?()
                }) {
                    Image("add-square")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Spacer()
                Button(action: {onRemove?()}) {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 22, height: 25)
                }

            }.padding(.trailing, 10)
        }
        .padding(10)
    }
}
