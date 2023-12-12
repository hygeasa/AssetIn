//
//  TakeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI

class TakeViewModel : ObservableObject {
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var place : String = "Koperasi"
    @Published var category: String = "School Supplies"
    
    @Published var data = []
}
