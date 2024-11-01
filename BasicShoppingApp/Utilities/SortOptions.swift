//
//  SortOptions.swift
//  BasicShoppingApp
//
//  Created by Gürkan Karadaş on 1.11.2024.
//

import SwiftUI

enum SortOptions: String, CaseIterable, Identifiable {
    case priceAscending, priceDescending = "Price"
    case ratingAscending, ratingDescending = "Stars"
    
    var id: String {rawValue}
    
    var iconName: String{
        switch self{
        case .priceAscending:
            return "arrow.up"
        case .priceDescending:
            return "arrow.down"
        case .ratingAscending:
            return "arrow.up"
        case .ratingDescending:
            return "arrow.down"
        }
    }
    
}
