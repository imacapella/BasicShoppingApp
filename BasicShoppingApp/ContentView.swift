//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dao = ProductsDao()
    @StateObject var favoriteProducts = FavoritedProducts()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    let numberOfRows = dao.products.count / 2

                    if numberOfRows > 0 {
                        ForEach(0..<numberOfRows, id: \.self) { row in
                            let startIndex = row * 2
                            let endIndex = min(startIndex + 1, dao.products.count - 1)
                            
                            HStack {
                                ForEach(startIndex...endIndex, id: \.self) { index in
                                    ProductCardView(product: $dao.products[index], favoriteItems: favoriteProducts)
                                }
                            }
                        }
                    }

                    else{
                        ProgressView("Loading Products...")
                    }
                    
                }.onAppear {
                    dao.fetchData()
                    }
            }
        }
    }
}

// MARK: - TAB VIEW
/*TabView {
    Text("Blabla")
        .tabItem {
            Label("Products", systemImage: "list.bullet")
        }

    Text("Favorites")
        .tabItem {
            Label("Favorites", systemImage: "heart")
        }

    Text("Cart")
        .tabItem {
            Label("Cart", systemImage: "cart")
        }
}*/
// MARK: - TAB VIEW

/*VStack {
    ForEach(0..<dao.products.count / 2, id: \.self) { row in
        HStack(spacing: 16) { // Kartlar arasındaki boşluk
            ForEach(0..<2) { column in
                let productIndex = row * 2 + column
                if productIndex < dao.products.count {
                    ProductCardView(product: dao.products[productIndex])
                        .padding(.bottom)
                }
            }
        }
        .padding(.horizontal, 16) // Yatayda ekranın kenarlarına boşluk ekliyoruz
        .padding(.vertical, 26)    // Kartların üst ve altına boşluk
    }
}
.padding()
.background(Color.gray.opacity(0.1))
.onAppear {
dao.fetchData()
}*/



#Preview {
    ContentView()
    
}

struct ProductCardView: View {
    @Binding var product: Product// Product nesnesi parametre olarak alınıyor
    @ObservedObject var favoriteItems: FavoritedProducts
    @State var isFavorite: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isFavorite.toggle()
                    if isFavorite {
                        // Favori listesine ekle
                        self.favoriteItems.favoriteProducts.append(product)
                    } else {
                        
                        // Favori listesinden çıkar (Bu kısmı tam çözemedim hayırlısı diyelim allah büyük)
                        if let index = self.favoriteItems.favoriteProducts.firstIndex(where: { $0.id == product.id }) {
                            self.favoriteItems.favoriteProducts.remove(at: index)
                        }
                    }
                      // Favori durumunu değiştir
                    print(product.title, isFavorite, favoriteItems.favoriteProducts)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .animation(.easeIn(duration: 0.1))
                .padding()
            }
            
            //Spacer()
            
            // Ürün görseli
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                // Ürün adı
                Text(product.title)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                // Ürün açıklaması
                Text("dadawdwadd")
                    .font(.title3)
                    .padding(.horizontal)
            }
            
            HStack {
                // Ürün fiyatı
                Text("$\(product.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                
                Spacer()
                
                // Ürün değerlendirmesi
                Text("⭐ \(String(format: "%.1f", product.rating))")
                    .fontWeight(.semibold)
            }
            .padding()
        }
        
       /* .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 15)
        )
        .frame(width: 170, height: 200)
        //.padding()*/
    }
}


