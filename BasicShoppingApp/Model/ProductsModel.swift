import Foundation

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let rating: Double
}

struct ProductsResponse: Codable {
    let products: [Product]
}

class FavoritedProducts: ObservableObject {
    @Published var favoriteProducts : [Product] = []
}

class AddToCard : ObservableObject {
    @Published var addedProducts : [Product] = []
}
