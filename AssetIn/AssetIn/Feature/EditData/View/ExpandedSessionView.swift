//
//  ExpandedSessionView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI

struct ExpandedSessionView: View {
    
    @ObservedObject var viewModel: EditDataViewModel
    @State var title: String
    @Binding var inventory: [Inventaris]
    @State private var isExpanded = false
    let navigation: (String) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .frame(width: 20)
                .foregroundColor(.AssetIn.yellow2)
            
            VStack {
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing : 5){
                            Text(title)
                                .font(.system(size: 17, weight: .bold))
                            
                            HStack(spacing: 5){
                                Text("\(inventory.count)")
                                    .font(.system(size: 13, weight: .regular))
                                Text("item")
                                    .font(.system(size: 13, weight: .regular))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Image(systemName: "chevron.down")
                            .fontWeight(.bold)
                            .foregroundColor(.AssetIn.orange)
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .padding(.horizontal, 20)
                    }
                    .foregroundColor(.black)
                }
                
                if isExpanded {
                    VStack {
                        ForEach(inventory, id: \.id) { item in
                            Button {
                                if let id = item.id {
                                    navigation(id)
                                }
                            } label: {
                                HStack(spacing: 12) {
                                    Text(item.namaInventaris)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "chevron.right")
                                }
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal)
                                .background(Color.AssetIn.yellow.cornerRadius(50))
                            }
                        }
                        
                        Button {
                            viewModel.currentCategory = title
                            viewModel.isShowAddData = true
                        } label: {
                            Text("Add Item")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(12)
                                .frame(maxWidth: 150)
                                .background(Color.AssetIn.orange.cornerRadius(12))
                        }
                        .padding(.top)
                    }
                    .padding()
                }
            }
        }
        .background(Color.white)
        .frame(minHeight: 100)
        .cornerRadius(20)
    }
}

#Preview {
    EditDataView(viewModel: .init(), navigator: .init())
}
