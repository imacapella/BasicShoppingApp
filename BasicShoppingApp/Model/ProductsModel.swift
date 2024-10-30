import Foundation

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let rating: Double
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    
}

struct CartItem: Identifiable, Codable, Equatable {
    var id: Int
    var product: Product
    var quantity: Int
}

struct ProductsResponse: Codable {
    let products: [Product]
}

class FavoritedProducts: ObservableObject {
    @Published var favoriteProducts : [Product] = []
}

class Cart : ObservableObject {
    @Published var cartItems : [CartItem]
    init() {
        self.cartItems = []
    }
}

class CardDetailView : ObservableObject {
    @Published var cardDetail : [Product] = []
}
