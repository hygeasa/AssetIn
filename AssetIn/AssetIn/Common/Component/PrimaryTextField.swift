//
//  PrimaryTextField.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

struct PrimaryTextField: View {
    
    @State var label: String?
    @Binding var text: String
    @State var placeholder: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let label {
                Text(label)
                    .font(.headline)
            }
            
            TextField(placeholder, text: $text)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .tint(Color.AssetIn.orange)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .strokeBorder(isFocused ? Color.AssetIn.orange : Color.AssetIn.greyChecklist)
                }
                .focused($isFocused)
        }
    }
}

#Preview {
    PrimaryTextField(label: "Quantity", text: .constant("10"), placeholder: "10")
}
