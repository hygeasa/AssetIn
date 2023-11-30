//
//  HomeView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 21/11/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel : HomeViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        ScrollView {
            VStack(spacing : 32) {
                
                HStack{
                    VStack(alignment : .leading, spacing : 2){
                        Text("Hi, \(viewModel.name)")
                            .font(.system(size: 17, weight: .semibold))
                        Text("NIS : \(viewModel.NIS)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.AssetIn.orange)
                    }
                    Spacer()
                    VStack(spacing : 2) {
                        Text("Siswa")
                        Text(viewModel.userclass)
                    }
                    .font(.system(size: 12, weight: .medium))
                    .offset(x: -15, y: 8)
                }
                .padding()
                .padding(.vertical, 10)
                .background(
                    Color.white
                        .cornerRadius(15)
                )
                .overlay(alignment: .topTrailing) {
                    Image.imageProfile
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(x: -25, y: -25)
                }
                .padding()
                
                TabView{
                    AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                        .frame(width: 320, height: 202)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                        .frame(width: 320, height: 202)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                        .frame(width: 320, height: 202)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                        .frame(width: 320, height: 202)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .tint(.AssetIn.orange)
                .tabViewStyle(.page)
                .frame(height: 200)
                
                HStack{
                    Button {
                    } label: {
                        VStack {
                            
                            Image.searchIcon
                                .resizable()
                                .scaledToFit()
                                .frame(width : 65, height : 65)
                                .offset()
                            Text("Search")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(15)
                    }
                    
                    Button {
                    } label: {
                        VStack {
                            Image.historyIcon
                                .resizable()
                                .scaledToFit()
                                .frame(width : 60, height : 60)
                                .offset()
                            Text("History")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(15)
                    }
                    
                    Button {
                    } label: {
                        VStack {
                            Image.ongoingIcon
                                .resizable()
                                .scaledToFit()
                                .frame(width : 60, height : 60)
                                .offset()
                            Text("On Going")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(15)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 30)
                .background(
                    Color.white
                        .cornerRadius(15)
                )
            }
            .padding(30)
            
            HStack(content: {
                Text("My Stuff")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                Button {
                } label: {
                    Text("Take")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.AssetIn.orange)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(
                            Color.white
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 5)
                        )
                    
                }
                .padding()
            })
            .padding(5)
            .padding(.horizontal,40)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange, Color.yellow]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 200
                        )
                        .edgesIgnoringSafeArea(.all)
                        .cornerRadius(15)
            )
        }
        .background(Color.AssetIn.grey)
    }
}

#Preview {
    MainView(navigator: .init())
}
