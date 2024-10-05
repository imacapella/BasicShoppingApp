//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var isLoading = true
    var dao = ProductsDao()
    var body: some View {
        ProductsListView()
    }
}

#Preview {
    ContentView()
    
}

