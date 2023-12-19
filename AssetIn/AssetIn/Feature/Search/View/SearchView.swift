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
                
                Button {
                    navigator .navigate(to: .searchdetail(.init(), navigator))
                }label: {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.AssetIn.greyText)
                        Text("Search")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.AssetIn.greyText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                
                ScrollView {
                VStack {
                    HStack {
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            //Text("School suplies")
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))/*(cornerRadius: [0,20,20,0]))*/
                            .overlay(alignment: .bottomLeading) {
                                Text("School Suplies")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))
                            .overlay(alignment: .bottomLeading) {
                                Text("Music Equipment")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                    }

                    HStack {
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))/*(cornerRadius: [0,20,20,0]))*/
                            .overlay(alignment: .bottomLeading) {
                                Text("Classroom Suplies")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))
                            .overlay(alignment: .bottomLeading) {
                                Text("Laboratory Stuff")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        

                    }
                    HStack {
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))/*(cornerRadius: [0,20,20,0]))*/
                            .overlay(alignment: .bottomLeading) {
                                Text("Sports Equipment")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))
                            .overlay(alignment: .bottomLeading) {
                                Text("Laboratory Equipment")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))/*(cornerRadius: [0,20,20,0]))*/
                            .overlay(alignment: .bottomLeading) {
                                Text("School Suplies")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 160, height: 178)
                            .clipShape(RoundedRectangle (cornerRadius:15))
                            .overlay(alignment: .bottomLeading) {
                                Text("School Suplies")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }

                    }
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
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView(viewModel: .init(), navigator: .init())
}
