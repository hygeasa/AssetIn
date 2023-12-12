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
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.AssetIn.greyText)
                TextField("Search", text: $viewModel.search)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.AssetIn.greyText)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
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
                        
                    Text(viewModel.category)
                        .font(.system(size: 12, weight: .medium))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                }
                
                Divider()
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(1...8, id: \.self) { index in
                        Button {
                            viewModel.isShowAlert = true
                        } label: {
                            VStack(spacing:0) {
                                AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                                    .frame(maxWidth: 360, maxHeight: 220)
                                
                                VStack(alignment: .leading,spacing:3) {
                                    Text(viewModel.inventaris)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    HStack(spacing: 2) {
                                        Text("Stock : ")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.AssetIn.orange)
                                        Text("\(viewModel.stock)")
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
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.AssetIn.orange)
                                    .background(Color.white.clipShape(Circle()))
                                    .frame(width: 40, height: 40)
                                    .offset(x: -20, y: -54)
                                    .shadow(color: .black.opacity(0.1), radius: 5)
                            }
                        }
                    }
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
        .alert("Add this item to ongoing?", isPresented: $viewModel.isShowAlert) {
            TextField("0", text: $viewModel.quantity)
                .keyboardType(.numberPad)
            
            Button(role: .cancel) {
                
            } label: {
                Text("Back")
            }
            
            Button() {
                viewModel.isRequest = true
            } label: {
                Text("Add")
            }
        } message: {
            Text("")
        }
        .alert(isPresented: $viewModel.isRequest, content: {
            Alert(title: Text("Thank you"), message: Text("Your request will be process soon!"), dismissButton: .default(Text("Okay"), action: {
                navigator.back()
            }))
        })
    }
}

#Preview {
    SearchDetailView(viewModel: .init(), navigator: .init())
}
