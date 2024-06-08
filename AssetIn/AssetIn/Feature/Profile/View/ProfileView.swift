//
//  ProfileView.swift
//  AssetIn
//
//  Created by Irham Naufal on 08/06/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var navigator: AppNavigator
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                HeaderView()
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 18, pinnedViews: .sectionHeaders) {
                        userInfoSection
                        
                        VStack(alignment: .leading) {
                            Text("Profile Menu")
                                .font(.headline)
                                .foregroundStyle(.black)
                            
                            menuTile(
                                title: "Account",
                                desc: "Change your account data",
                                icon: Image(systemName: "person.circle")) {
                                    
                                }
                            
                            menuTile(
                                title: "Password",
                                desc: "Change your password",
                                icon: Image(systemName: "lock.circle")) {
                                    
                                }
                        }
                        
                        Button {
                            viewModel.isShowLogoutAlert = true
                        } label: {
                            HStack {
                                Text("Log Out")
                                
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.red.opacity(0.15))
                            )
                        }
                        .padding(.vertical)
                    }
                    .padding()
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
        .alert("Are you sure?", isPresented: $viewModel.isShowLogoutAlert, actions: {
            Button("Okay", role: .destructive) {
                viewModel.logOut {
                    navigator.backHome()
                }
            }
        }, message: {
            Text("After logging out, you will need to log in again to use Asset-In.")
        })
    }
}

extension ProfileView {
    @ViewBuilder
    var userInfoSection: some View {
        HStack {
            AvatarPlaceholder(url: viewModel.user?.avatar)
            
            VStack(alignment: .leading, spacing: 4) {
                Text((viewModel.user?.name) ?? "–")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text("NIS: \((viewModel.user?.nis) ?? "–")")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.AssetIn.orange)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 0.5)
                .strokeBorder(Color.AssetIn.greyChecklist, lineWidth: 0.5)
        )
    }
    
    @ViewBuilder
    func menuTile(
        title: String,
        desc: String,
        icon: Image,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    icon
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.ultraLight)
                        .frame(width: 30, height: 30)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        
                        Text(desc)
                            .font(.caption)
                            .foregroundStyle(Color.AssetIn.greyText)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.AssetIn.greyText)
                }
                .padding(.bottom, 8)
                Divider()
            }
        }
        .padding(.top, 8)
    }
}

#Preview {
    MainView(navigator: .init())
}
