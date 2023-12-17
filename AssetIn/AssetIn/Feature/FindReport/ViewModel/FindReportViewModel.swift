//
//  FindReportViewModel.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

class FindReportViewModel: ObservableObject {
    @Published var date = "22 Jun 2023"
    
    @Published var name : String = "Iam jelek"
    @Published var NIS : String = "1234"
    @Published var userclass : String = "2A"
    @Published var deadline : String = "10/06/2023"
    @Published var inventory : String = "Proyektor"
    @Published var category : String = "School suplies"
    @Published var lending : String = "05/06/2023"
}
