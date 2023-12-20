//
//  EditNewsView.swift
//  AssetIn
//
//  Created by Irham Naufal on 21/12/23.
//

import SwiftUI

struct EditNewsView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @FocusState var focused: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        viewModel.resetNewsData()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Edit News")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button("Save") {
                        viewModel.updateNews()
                    }
                    .tint(viewModel.updateNewsDisabled ? .AssetIn.greyChecklist : .AssetIn.orange)
                    .disabled(viewModel.updateNewsDisabled)
                }
                .padding(8)
                Divider()
            }
            
            ScrollView {
                VStack(spacing: 18) {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.system(size: 14, weight: .semibold))
                        
                        TextField("News title here...", text: $viewModel.newsTitle)
                            .font(.system(size: 12,  weight: .regular ))
                            .tint(.AssetIn.orange)
                            .padding()
                            .background(focused == 1 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.AssetIn.orange, lineWidth: focused == 1 ? 1 : 0)
                                    .foregroundColor(.AssetIn.orange)
                            }
                            .cornerRadius(10)
                            .tag(1)
                            .focused($focused, equals: 1)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("URL")
                            .font(.system(size: 14, weight: .semibold))
                        
                        TextField("News url here...", text: $viewModel.newsURL)
                            .font(.system(size: 12,  weight: .regular ))
                            .tint(.AssetIn.orange)
                            .padding()
                            .background(focused == 2 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.AssetIn.orange, lineWidth: focused == 2 ? 1 : 0)
                                    .foregroundColor(.AssetIn.orange)
                            }
                            .cornerRadius(10)
                            .tag(2)
                            .focused($focused, equals: 2)
                    }
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EditNewsView(viewModel: .init())
}
