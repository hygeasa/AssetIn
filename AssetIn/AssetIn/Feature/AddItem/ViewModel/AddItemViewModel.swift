//
//  AddItemViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

class AddItemViewModel: ObservableObject {
    @Published var category = "Music Equipment"
    @Published var stock = "6"
    @Published var item = "Piano"
}
    
