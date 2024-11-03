//
//  EmptyView.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 3.11.2024.
//

import SwiftUI

struct CartEmptyView: View {
    var icon: String
    var headline: String
    var desc: String
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            Text(headline)
                .font(.headline)

            Text(desc)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}
