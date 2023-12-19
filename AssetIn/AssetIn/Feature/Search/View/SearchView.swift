//
//  SearchView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel : SearchViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack(spacing: 20) {
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
                if !viewModel.isAdmin {
                    Image.imageProfile
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }else {
                    Image.logoAssetin
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.AssetIn.greyText)
                
                TextField("Search...", text: $viewModel.searchText)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.AssetIn.greyText)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [.init(.flexible(), spacing: 12), .init(.flexible())], spacing: 12, content: {
                    ForEach(viewModel.searchedCategories, id:\.id) { item in
                        Button {
                            navigator.navigate(to: .searchdetail(.init(category: item), navigator))
                        } label: {
                            item.image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 170)
                                .overlay {
                                    ZStack(alignment: .bottomLeading) {
                                        LinearGradient(
                                            colors: [.black.opacity(0.6), .clear],
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                        
                                        Text(item.name)
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .animation(.spring(), value: viewModel.searchText)
                })
                .padding([.horizontal, .bottom])
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
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView(viewModel: .init(), navigator: .init())
}
