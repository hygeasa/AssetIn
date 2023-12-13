//
//  HomeViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 21/11/23.
//

import Foundation
class HomeViewModel : ObservableObject {
    @Published var name : String = "Iam jelek"
    @Published var NIS : String = "1234"
    @Published var userclass : String = "2A"
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
    
    
    @Published var isAdmin: Bool = true
}
