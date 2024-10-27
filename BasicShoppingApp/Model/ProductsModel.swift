import Foundation

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let rating: Double
    let warrantInformation: String
    let shippingInformation: String
    let availabilityStatus: String
}

struct ProductsResponse: Codable {
    let products: [Product]
}

class FavoritedProducts: ObservableObject {
    @Published var favoriteProducts : [Product] = []
}

class CartItems : ObservableObject {
    @Published var quantity : Int = 0
    @Published var cartItems : [Product] = []
}

class CardDetailView : ObservableObject {
    @Published var cardDetail : [Product] = []
}
