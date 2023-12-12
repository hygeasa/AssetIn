//
//  HistoryViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
    
    
    @Published var data = []
}


