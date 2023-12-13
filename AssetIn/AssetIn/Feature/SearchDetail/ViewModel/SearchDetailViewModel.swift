//
//  SearchDetailViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI

class SearchDetailViewModel : ObservableObject {
    @Published var search: String = ""
    @Published var category: String = "School Supplies"
    @Published var inventaris: String = "Proyektor"
    @Published var stock: Int = 4
    
    @Published var isShowAlert = false
    @Published var quantity = "1"
    @Published var isRequest = false
    
    @Published var isAdmin : Bool = true
}
