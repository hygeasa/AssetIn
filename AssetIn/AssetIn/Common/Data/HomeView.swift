//
//  HomeView.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var navigator: AppNavigator
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                header
                
                ScrollView {
                    LazyVStack(spacing: 18, pinnedViews: .sectionHeaders) {
                        slidingBanner(geo)
                        if !viewModel.loans.isEmpty {
                            requestSection(geo)
                        }
                        borrowSection
                    }
                    .padding(.vertical, 30)
                    .padding(.top, 24)
                }
                .refreshable {
                    viewModel.onAppear()
                }
            }
            .onAppear {
                viewModel.onAppear()
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

extension HomeView {
    @ViewBuilder
    var header: some View {
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
                    
                    Button {
                        SystemSettings.shared.mainTabSelection = .profile
                    } label: {
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
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 10)
                .padding()
                .offset(y: 24)
            }
            .zIndex(100)
    }
    
    @ViewBuilder
    func slidingBanner(_ geo: GeometryProxy) -> some View {
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
                                    .frame(maxWidth: geo.size.width-30, maxHeight: (geo.size.width-30)*2/5)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
            .frame(height: (geo.size.width-30)*2/5)
            
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
    
    @ViewBuilder
    func requestSection(_ geo: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("Your Requests")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    navigator.navigate(to: .history(.init()))
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .font(.headline)
                    .foregroundStyle(Color.AssetIn.orange)
                }
            }
            .padding(.bottom, 6)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.loans.prefix(3)) { loan in
                        Button {
                            navigator.navigate(to: .history(.init(status: loan.status)))
                        } label: {
                            HStack(alignment: .top, spacing: 8) {
                                AsyncImage(url: URL.imagePath((loan.inventory?.photo).orEmpty())) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text((loan.status?.rawValue).orEmpty())
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 12)
                                        .background(Capsule().fill(loan.status?.rawValue == "REQUEST" ? Color.AssetIn.orange : Color.AssetIn.green))
                                    
                                    Text((loan.inventory?.name).orEmpty())
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    
                                    Text(loan.status?.rawValue == "REQUEST" ? "Still processing.." : "Take it at \(loan.pickupLocation.orEmpty())"
                                    )
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.AssetIn.greyText)
                                    
                                    Text("Deadline: \((loan.dueDate?.dateDisplay(.slash)).orEmpty())")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.AssetIn.orange)
                                        .padding(.top, 1)
                                }
                            }
                            .frame(width: geo.size.width-100, alignment: .leading)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .strokeBorder(Color.AssetIn.greyChecklist, lineWidth: 0.5)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var borrowSection: some View {
        VStack(alignment: .leading) {
            Text("Need Something?")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 6)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 6)], spacing: 6) {
                ForEach(CategoryType.allCases) { category in
                    Button {
                        
                    } label: {
                        category.image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .overlay {
                                Color.black.opacity(0.4)
                                Text(category.name)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView(navigator: .init())
}
