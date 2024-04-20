//
//  HomeView.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                HeaderView()
                    .overlay {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text((viewModel.user?.name) ?? "–")
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("NIS: \((viewModel.user?.nis) ?? "–")")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.AssetIn.orange)
                            }
                            Spacer()
                            
                            Group {
                                if let imageURL = viewModel.user?.avatar {
                                    AsyncImage(url: .imagePath(imageURL)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        }
                                    }
                                } else {
                                    Image.imageProfile
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.1), radius: 10)
                        .padding()
                        .offset(y: 24)
                    }
                    .zIndex(100)
                
                ScrollView {
                    LazyVStack(spacing: 18, pinnedViews: .sectionHeaders) {
                        VStack {
                            TabView(selection: $viewModel.currentBanner) {
                                ForEach(viewModel.announcements.indices, id: \.self) { index in
                                    let news = viewModel.announcements[index]
                                    Button {
                                        viewModel.isShowSafari = true
                                    } label: {
                                        AsyncImage(url: .imagePath(news.banner.orEmpty())) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(maxWidth: geo.size.width-20, maxHeight: 200)
                                                    .cornerRadius(30, corners: [.topRight, .bottomLeft])
                                            }
                                        }
                                    }
                                    .tag(index)
                                    .fullScreenCover(isPresented: $viewModel.isShowSafari) {
                                        SafariWebView(url: URL(string: news.link.orEmpty())!)
                                            .ignoresSafeArea()
                                    }
                                }
                            }
                            .tint(.AssetIn.orange)
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 200)
                            
                            HStack(spacing: 8) {
                                ForEach(viewModel.announcements.indices, id: \.self) { index in
                                    Capsule()
                                        .foregroundColor(index == viewModel.currentBanner ? .AssetIn.orange : .AssetIn.greyChecklist)
                                        .frame(width: index == viewModel.currentBanner ? 36 : 8, height: 8)
                                        .animation(.spring(), value: viewModel.currentBanner)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 30)
                    .padding(.top, 24)
                }
                .refreshable {
                    viewModel.getAnnonucementList()
                    viewModel.getUserData()
                }
            }
            .onAppear {
                viewModel.getAnnonucementList()
                viewModel.getUserData()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .alert(viewModel.alertTitle, isPresented: $viewModel.isShowAlert, actions: {
            Button("Okay") {}
        }, message: {
            Text(viewModel.alertMessage)
        })
    }
}

#Preview {
    HomeView()
}
