//
//  InventoryView.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

struct InventoryView: View {
    
    @StateObject var viewModel: InventoryViewModel
    @Environment(\.dismiss) var back
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                    mainContent
                }
            }
            .refreshable {
                viewModel.onAppear()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.onAppear()
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isShowAlert, actions: {
            Button("Okay") {}
        }, message: {
            Text(viewModel.alertMessage)
        })
    }
}

extension InventoryView {
    @ViewBuilder
    var header: some View {
        HeaderView {
            Button("Inventory", systemImage: "chevron.left") {
                back()
            }
            .font(.headline)
            .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    var mainContent: some View {
        Section {
            if viewModel.inventories.isEmpty {
                DefaultEmptyView()
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 8) {
                    ForEach(viewModel.inventories) { inventory in
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading, spacing: 0) {
                                AsyncImage(url: URL.imagePath((inventory.photo).orEmpty())) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: 150)
                                            .clipped()
                                    }
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    Text(inventory.name.orEmpty())
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    
                                    Text("Stock: \(inventory.quantity.orZero())")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.AssetIn.orange)
                                }
                                .multilineTextAlignment(.leading)
                                .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .strokeBorder(Color.AssetIn.greyChecklist, lineWidth: 0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        } header: {
            contentHeader
        }
    }
    
    @ViewBuilder
    var contentHeader: some View {
        HStack {
           Image(systemName: "slider.horizontal.3")
                .font(.headline)
                .foregroundStyle(Color.AssetIn.orange)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(CategoryType.allCases) { category in
                        Button {
                            viewModel.getInventoryList(category: category)
                        } label: {
                            Text(category.name.capitalized)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background {
                                    Capsule()
                                        .fill(viewModel.category == category ? Color.AssetIn.orange.opacity(0.2) : Color.AssetIn.greyChecklist.opacity(0.5))
                                }
                                .overlay {
                                    if viewModel.category == category {
                                        Capsule()
                                            .inset(by: 0.5)
                                            .strokeBorder(Color.AssetIn.orange)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(.vertical, 8)
        .background(.white)
    }
}

#Preview {
    InventoryView(viewModel: .init(category: .furniture))
}
