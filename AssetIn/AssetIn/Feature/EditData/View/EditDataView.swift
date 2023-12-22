//
//  EditDataView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI
import PhotosUI

struct EditDataView: View {
    
    @ObservedObject var viewModel : EditDataViewModel
    @ObservedObject var navigator : AppNavigator
    @FocusState var focused: Int?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("What are you looking for?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            
            VStack(spacing: 2){
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.AssetIn.greyText)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                
                ScrollView {
                    VStack(spacing: 5) {
                        ExpandedSessionView(viewModel: viewModel, title: "Furniture", inventory: $viewModel.furnitureData) { id in
                            
                        }
                        ExpandedSessionView(viewModel: viewModel, title: "Music", inventory: $viewModel.musicData) { id in
                            
                        }
                        ExpandedSessionView(viewModel: viewModel, title: "Classroom", inventory: $viewModel.classroomData) { id in
                            
                        }
                        ExpandedSessionView(viewModel: viewModel, title: "Laboratory", inventory: $viewModel.labData) { id in
                            
                        }
                        ExpandedSessionView(viewModel: viewModel, title: "Sports", inventory: $viewModel.sportsData) { id in
                            
                        }
                        ExpandedSessionView(viewModel: viewModel, title: "Library", inventory: $viewModel.libraryData) { id in
                            
                        }
                    }
                    .padding()
                }
            }
        }
        .background(
            VStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange, Color.yellow]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 200
                )
                .frame(height: 130)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(15)
                Spacer()
            }
                .ignoresSafeArea()
        )
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .onAppear {
            viewModel.getInventories()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $viewModel.isShowAddData, content: {
            AddItemView()
        })
    }
}

extension EditDataView {
    @ViewBuilder
    func AddItemView() -> some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        viewModel.resetData()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Add Item")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.clear)
                }
                .padding(8)
                Divider()
            }
            
            ScrollView {
                VStack(spacing: 18) {
                    Text(viewModel.currentCategory)
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
                                ZStack {
                                    Color.AssetIn.grey
                                    
                                    VStack {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 50)
                                        
                                        Text("Add Photo")
                                    }
                                    .foregroundColor(.AssetIn.greyText)
                                }
                            } else {
                                Image(uiImage: viewModel.imagePlaceholder)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(alignment: .bottomTrailing) {
                            if viewModel.imagePlaceholder != UIImage() {
                                Text("Change Photo")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .padding(.horizontal, 8)
                                    .background(Capsule().foregroundColor(.white))
                                    .padding()
                            }
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
            
            Button {
                viewModel.uploadImage()
            } label: {
                Text("Accept")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(viewModel.acceptButtonDisabled ? .AssetIn.greyChecklist : .AssetIn.orange)
                    )
                    .padding()
            }
            .disabled(viewModel.acceptButtonDisabled)
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
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(
                title: Text(viewModel.isError ? "Oops.." : "Yeay!"),
                message: Text(viewModel.isError ? viewModel.errorText : "You successfully add the item"),
                dismissButton: .default(Text("Okay"), action: {
                    viewModel.getInventories()
                    viewModel.isShowAddData = false
                })
            )
        }
    }
}

#Preview {
    EditDataView(viewModel: .init(), navigator: .init())
}
