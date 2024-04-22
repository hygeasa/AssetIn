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
    @Namespace var namespace
    
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
        .overlay { detailView }
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
                            viewModel.openDetail(inventory)
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
                                .matchedGeometryEffect(id: "IMAGE\(inventory.id.orZero())", in: namespace)
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    Text(inventory.name.orEmpty())
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                        .matchedGeometryEffect(id: "TITLE\(inventory.id.orZero())", in: namespace)
                                    
                                    Text("Stock: \(inventory.quantity.orZero())")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.AssetIn.orange)
                                        .matchedGeometryEffect(id: "STOCK\(inventory.id.orZero())", in: namespace)
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
                            .matchedGeometryEffect(id: "CARD\(inventory.id.orZero())", in: namespace)
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
    
    @ViewBuilder
    var detailView: some View {
        if let inventory = viewModel.currentInventory {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL.imagePath((inventory.photo).orEmpty())) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: geo.size.width)
                                        .clipped()
                                }
                            }
                            .ignoresSafeArea()
                            .matchedGeometryEffect(id: "IMAGE\(inventory.id.orZero())", in: namespace)
                            
                            VStack(alignment: .leading) {
                                Text(inventory.name.orEmpty())
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .matchedGeometryEffect(id: "TITLE\(inventory.id.orZero())", in: namespace)
                                
                                Text("Stock: \(inventory.quantity.orZero())")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.AssetIn.orange)
                                    .matchedGeometryEffect(id: "STOCK\(inventory.id.orZero())", in: namespace)
                            }
                            .multilineTextAlignment(.leading)
                            .padding()
                            
                            PrimaryTextField(label: "Quantity", text: $viewModel.quantityTextField, placeholder: "5")
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Date")
                                    .font(.headline)
                                DatePicker(
                                    "",
                                    selection: $viewModel.loanDate,
                                    in: Date.now...,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                                .tint(Color.AssetIn.orange)
                                .labelsHidden()
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 40)
                    }
                    
                    Button {
                        viewModel.createLoan()
                    } label: {
                        Text("Borrow")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(viewModel.disableBorrow ? Color.AssetIn.greyChecklist : Color.AssetIn.orange)
                            )
                    }
                    .disabled(viewModel.disableBorrow)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.white)
                .overlay(alignment: .topTrailing) {
                    Button {
                        viewModel.closeDetail()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(Color.AssetIn.greyChecklist)
                    }
                    .padding()
                }
                .matchedGeometryEffect(id: "CARD\(inventory.id.orZero())", in: namespace)
            }
        }
    }
}

#Preview {
    InventoryView(viewModel: .init(category: .furniture))
}
