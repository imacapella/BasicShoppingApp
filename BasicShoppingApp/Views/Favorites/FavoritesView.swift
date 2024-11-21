import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @ObservedObject var favoriteItems: FavoritedProducts
    var product: Product?
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            if favoriteItems.favoriteProducts.isEmpty {
                VStack {
                    Spacer()
                    EmptyInfoView(icon: "heart", headline: "You have no favorite products yet.", desc: "Add more goods to your product!")
                    Spacer()
                }
                .navigationTitle("Favorites")
            } else {
                ScrollView {
                    VStack {
                        ForEach(favoriteItems.favoriteProducts) { product in
                            FavoritesCardView(favoriteItems: favoriteItems, product: product, viewModel: viewModel)
                                .padding(7)
                        }
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}
