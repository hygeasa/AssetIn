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
                
                if !viewModel.isAdmin {
                    HStack{
                        VStack(alignment : .leading, spacing : 2){
                            Text("Hi, \(viewModel.userData?.nama ?? "–")")
                                .font(.system(size: 17, weight: .semibold))
                            Text("NIS : \(viewModel.userData?.nis ?? "–")")
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
                        Group {
                            if let imageURL = viewModel.userData?.imageURL {
                                AsyncImage(url: URL(string: imageURL))
                                    .scaledToFill()
                            } else {
                                Image.imageProfile
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .offset(x: -25, y: -25)
                    }
                }else {
                    Text("Hi, Admin!")
                        .font(.system(size : 17, weight : .semibold))
                        .padding()
                        .padding(.vertical, 10)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                
                TabView{
                    ForEach(viewModel.news, id: \.id) { news in
                        Button {
                            viewModel.isShowSafari = true
                        } label: {
                            AsyncImage(url: URL(string: news.thumbnail ?? ""))
                                .frame(width: 320, height: 202)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(alignment : .bottomTrailing) {
                                    if viewModel.isAdmin {
                                        Button {
                                            
                                        } label: {
                                            Text("Edit news")
                                                .font(.system(size: 13, weight: .regular))
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(Color.white)
                                                .cornerRadius(20)
                                        }
                                        .padding()
                                    }
                                }
                        }
                        .fullScreenCover(isPresented: $viewModel.isShowSafari) {
                            SafariWebView(url: URL(string: news.url ?? "")!)
                                .ignoresSafeArea()
                        }
                    }
                }
                .tint(.AssetIn.orange)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 200)
                
                HStack{
                    Button {
                        navigator.navigate(to: .search(.init(), navigator))
                    } label: {
                        VStack {
                            Image.searchIcon
                                .resizable()
                                .scaledToFit()
                                .frame(width : 65, height : 65)
                                .offset()
                            Text("Search")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.black)
                        }
                        .padding(15)
                    }
                    
                    if !viewModel.isAdmin {
                        Button {
                            navigator.navigate(to: .history(.init(),navigator))
                        } label: {
                            VStack {
                                Image.historyIcon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                Text("History")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black)
                            }
                            .padding(15)
                        }
                    } else {
                        Button {
                            navigator.navigate(to: .report(.init(),navigator))
                        } label: {
                            VStack {
                                Image.historyIcon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                Text("Report")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black)
                            }
                            .padding(15)
                        }
                    }
                    
                    if !viewModel.isAdmin {
                        Button {
                            navigator.navigate(to: .ongoing(.init(), navigator))
                        } label: {
                            VStack {
                                Image.ongoingIcon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                Text("On Going")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black)
                            }
                            .padding(15)
                        }
                    } else {
                        Button {
                            navigator.navigate(to: .editdata(.init(), navigator))
                        } label: {
                            VStack {
                                Image.ongoingIcon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                Text("Edit data")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.black)
                            }
                            .padding(15)
                        }
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
            
            if !viewModel.isAdmin {
                HStack(content: {
                    Text("My Stuff")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    Button {
                        navigator.navigate(to: .take(.init(), navigator))
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
            } else {
                VStack {
                    ForEach(0...6, id:\.self) { index in
                        VStack(alignment: .leading, spacing: 5){
                            Text("On process")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.orange)
                                .cornerRadius(15)
                            
                            Text(viewModel.inventory)
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("Category: \(viewModel.category)")
                                .font(.system(size: 12, weight: .semibold))
                            
                            Text(viewModel.lending)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.AssetIn.greyText)
                                .padding(.vertical, 5)
                            
                            HStack {
                                Button {
                                    viewModel.isAccept = true
                                }label : {
                                    Text("Accept")
                                        .foregroundColor(.white)
                                        .font(.system(size :10, weight: .bold))
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 50)
                                        .background(Color.AssetIn.green)
                                        .cornerRadius(10)
                                }
                                
                                Text("Deadline: \(viewModel.deadline)")
                                    .font(.system(size: 10,weight: .bold))
                                    .foregroundColor(.AssetIn.orange)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                            }
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
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
                .frame(height: 112)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(15)
                Spacer()
            }
                .ignoresSafeArea()
        )
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .onAppear {
            viewModel.getUserData()
            viewModel.getNewsData()
        }
    }
    
}

#Preview {
    MainView(navigator: .init())
}
