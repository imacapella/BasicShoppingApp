//
//  FavoritesCardView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 3.11.2024.
//
import SwiftUI
import SDWebImageSwiftUI

struct FavoritesCardView: View {
    @ObservedObject var favoriteItems: FavoritedProducts
    var product: Product?
    @ObservedObject var viewModel : FavoritesViewModel

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if let product = product {
                        WebImage(url: URL(string: product.thumbnail))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 8) // Resim ile metin arasında boşluk

                        VStack(alignment: .leading) {
                            Text(product.title.count > 20 ? "\(product.title.prefix(20))..." : product.title)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }

                        Spacer() // Metin ile buton arasında boşluk

                        Button(action: {
                            viewModel.removeFromFavorites(product: product)
                            }) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19, height: 19)
                                .shadow(color: .red, radius: 2)
                                .foregroundColor(.red)
                                .padding(.trailing, 8)
                            }.animation(.bouncy)
                        
                        }
                    }
                }
                .padding(.vertical, 10) // Kart içeriği için dikeyde biraz boşluk
            }
            .padding(10) // Kartın genel kenar boşlukları

            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                    .shadow(color: .gray, radius: 20, x: 10, y: 20)
            )
        }
    }

