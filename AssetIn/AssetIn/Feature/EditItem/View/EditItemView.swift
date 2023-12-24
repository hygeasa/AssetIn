//
//  EditItemView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct EditItemView: View {
    @ObservedObject var viewModel : EditItemViewModel
    @ObservedObject var navigator : AppNavigator
    @FocusState var focused: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                navigator.back()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "chevron.left")
                    
                    Text("Edit Data")
                }
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange, Color.yellow]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 200
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .ignoresSafeArea()
            )
            
            ScrollView {
                VStack(spacing: 18) {
                    Text(viewModel.inventoryData?.category ?? "–")
                        .font(.system(size: 22,  weight: .semibold ))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.AssetIn.purple)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    Button {
                        viewModel.isShowImagePicker = true
                    } label: {
                        Group {
                            if viewModel.imagePlaceholder == UIImage() {
                                AsyncImage(url: URL(string: (viewModel.inventoryData?.gambar) ?? "")) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }

                            } else {
                                Image(uiImage: viewModel.imagePlaceholder)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(alignment: .bottomTrailing) {
                            Text("Change Photo")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Capsule().foregroundColor(.white))
                                .padding()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Inventory Name")
                            .font(.system(size: 14, weight: .semibold))
                        
                        TextField("Projector..", text: $viewModel.inventoryName)
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
                    
                    VStack(alignment: .leading) {
                        Text("Stock")
                            .font(.system(size: 14, weight: .semibold))
                        
                        TextField("0", text: $viewModel.inventoryStock)
                            .font(.system(size: 12,  weight: .regular ))
                            .tint(.AssetIn.orange)
                            .keyboardType(.numberPad)
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
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            HStack {
                Button {
                    viewModel.deleteItem {
                        navigator.back()
                    }
                } label: {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.red.opacity(0.1))
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color.red, lineWidth: 1)
                        }
                }
                
                Button {
                    viewModel.updateInventoryData()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(viewModel.acceptButtonDisabled ? .AssetIn.greyChecklist : .AssetIn.orange)
                        )
                }
                .disabled(viewModel.acceptButtonDisabled)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .photosPicker(
            isPresented: $viewModel.isShowImagePicker,
            selection: $viewModel.selectedImage,
            matching: .images
        )
        .onChange(of: viewModel.selectedImage) { _ in
            Task {
                await viewModel.changeImagePlaceholder()
            }
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.white)
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.getInventory()
        }
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text(viewModel.isError ? "Oops.." : "Yeay!"),
                message: Text(viewModel.isError ? viewModel.errorText : "You successfully change the item"),
                dismissButton: .default(Text("Okay"), action: {
                    viewModel.getInventory()
                })
            )
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditItemView(viewModel: .init(inventoryID: "054135DC-BF3D-42B6-AC32-4C1FE0F61428"), navigator: .init())
}
