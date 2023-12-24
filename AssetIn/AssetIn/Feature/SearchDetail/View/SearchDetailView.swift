//
//  SearchDetailView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchDetailView: View {
    @ObservedObject var viewModel : SearchDetailViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack(spacing: 5) {
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
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.AssetIn.greyText)
                TextField("Search", text: $viewModel.searchText)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.AssetIn.greyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                Divider()
                
                HStack{
                    Text("By Category : ")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.AssetIn.orange)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Text(viewModel.categoryText)
                        .font(.system(size: 12, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Divider()
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.searchedInventory, id: \.id) { item in
                        Button {
                            viewModel.isShowAlert = true
                            if viewModel.isAdmin {
                                viewModel.quantity = "\(item.stock)"
                                viewModel.currentInventory = item
                            }
                        } label: {
                            VStack(spacing:0) {
                                AsyncImage(url: URL(string: item.gambar)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    
                                }
                                    
                                
                                VStack(alignment: .leading,spacing:3) {
                                    Text(item.namaInventaris)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    HStack(spacing: 2) {
                                        Text("Stock : ")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.AssetIn.orange)
                                        Text("\(item.stock)")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.AssetIn.orange)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.white)
                            }
                            .cornerRadius(20)
                            .overlay(alignment: .bottomTrailing ) {
                                if !viewModel.isAdmin {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.AssetIn.orange)
                                        .background(Color.white.clipShape(Circle()))
                                        .frame(width: 40, height: 40)
                                        .offset(x: -20, y: -54)
                                        .shadow(color: .black.opacity(0.1), radius: 5)
                                } else {
                                    Text("Edit Stock")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.AssetIn.orange)
                                        .cornerRadius(20)
                                        .offset(x: -20, y: -54)
                                        .shadow(color: .black.opacity(0.1), radius: 5)
                                }
                            }
                        }
                        .alert(viewModel.isAdmin ? "Add item" : "Borrow this item?", isPresented: $viewModel.isShowAlert) {
                            TextField("0", text: $viewModel.quantity)
                                .keyboardType(.numberPad)
                            
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("Cancel")
                            }
                            
                            Button() {
                                viewModel.updateOrRequestInventory(item)
                            } label: {
                                Text("Add")
                            }
                        } message: {
                            Text("")
                        }
                    }
                    .animation(.spring(), value: viewModel.searchText)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getInventories()
            viewModel.getUserData()
        }
        .alert(isPresented: $viewModel.isRequest, content: {
            Alert(title: Text("Thank you"), message: Text( viewModel.isAdmin ? "The item has been successfully added." : "Your request will be process soon!"), dismissButton: .default(Text("Okay")))
        })
    }
}

#Preview {
    SearchDetailView(viewModel: .init(category: .init(name: "FURNITURE", image: .furniture)), navigator: .init())
}
