import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @ObservedObject var favoriteItems: FavoritedProducts
    var product: Product?

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        if favoriteItems.favoriteProducts.isEmpty{
                            EmptyInfoView(icon: "heart", headline: "You have no favorite products yet.", desc: "Add more goods to your product!")
                        }
                        else{
                            ForEach(favoriteItems.favoriteProducts) { product in
                                FavoritesCardView(favoriteItems: favoriteItems, product: product)
                            }
                        }
                    }
                }
            }
            .onAppear {
                print(favoriteItems.favoriteProducts.first?.thumbnail ?? "Invalid URL")
            }
            .navigationTitle("Favorites")
        }
    }
}

