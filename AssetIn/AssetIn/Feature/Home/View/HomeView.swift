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
                        Text("Hi, \(viewModel.userData?.nama ?? "–")")
                            .font(.system(size: 17, weight: .semibold))
                        Text("\(viewModel.isAdmin ? "NIP" : "NIS") : \(viewModel.userData?.nis ?? "–")")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.AssetIn.orange)
                    }
                    Spacer()
                    VStack {
                        Group {
                            if let imageURL = viewModel.userData?.imageURL {
                                AsyncImage(url: URL(string: imageURL)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }
                            } else {
                                if viewModel.isAdmin {
                                    Image.logoAssetin
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    Image.imageProfile
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        Text(viewModel.isAdmin ? "Admin" : "Student")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .padding()
                .background(
                    Color.white
                        .cornerRadius(15)
                )
                
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
                                            viewModel.showEditNews(news)
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
                VStack(alignment: .leading) {
                    Text("Requested")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.historyData, id:\.id) { item in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("On Process")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.orange)
                                .cornerRadius(15)
                            
                            Text(item.inventoryName ?? "–")
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("Category: \((item.categoryId ?? "").capitalized)")
                                .font(.system(size: 12, weight: .semibold))
                            
                            if let expiredAt = item.expiredAt {
                                Text(expiredAt.toString(format: .withSlash))
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.AssetIn.greyText)
                                    .padding(.vertical, 5)
                            }
                            
                            HStack {
                                HStack(spacing: 0) {
                                    Text("by ")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                    Text("\(item.studentName ?? "–") (\(item.studentNIS ?? "–"))")
                                        .foregroundColor(.AssetIn.purple)
                                        .font(.system(size: 12, weight: .semibold))
                                        .lineLimit(1)
                                }
                                
                                Button {
                                    viewModel.showRequestBottomSheet(item)
                                } label : {
                                    Text("Accept")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10, weight: .bold))
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 30)
                                        .background(Color.AssetIn.green)
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
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
            viewModel.getHistoryData()
        }
        .fullScreenCover(isPresented: $viewModel.isShowEditNews) {
            EditNewsView(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $viewModel.isShowAcceptBottomSheet) {
            AcceptRequestBottomSheet(viewModel: viewModel)
        }
    }
    
}

#Preview {
    MainView(navigator: .init())
}
