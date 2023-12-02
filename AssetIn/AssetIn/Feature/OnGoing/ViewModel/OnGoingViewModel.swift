//
//  OnGoingViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 01/12/23.
//

import SwiftUI

class OnGoingViewModel: ObservableObject {
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
}
