//
//  ProfileView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 05/12/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var navigator: AppNavigator
    
    var body: some View {
        VStack (spacing: 30){
            HStack {
                Text("Profile")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                if !viewModel.isAdmin {
                    Image.imageProfile
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }else {
                    Image.logoAssetin
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }
                
            }
            .padding(.horizontal)
            
            VStack(spacing: 30){
                VStack (alignment : .center) {
                    
                    if !viewModel.isAdmin {
                        Text(viewModel.name)
                            .font(.system(size: 17, weight:  .semibold))
                    }else {
                        Text("Admin")
                            .font(.system(size: 17, weight:  .semibold))
                    }
                    
                    Text(viewModel.email)
                        .font(.system(size: 15, weight: .regular))
                        .opacity(0.6)
                }
                VStack (alignment : .leading, spacing: 20) {
                    Button {
                        navigator.navigate(to: .changeprofile(.init(), navigator))
                    }label: {
                        HStack {
                            Image.photoprofile
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                            
                            Text("Change photo profile")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                        }
                    }
                    Button {
                        navigator.navigate(to: .changepassword(.init(), navigator))
                    }label: {
                        HStack {
                            Image.changepassword
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                            
                            Text("Change password")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                        }
                    }
                    
                    HStack {
                        Image.role
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        VStack (alignment : .leading) {
                            Text("Role user")
                                .font(.system(size: 15, weight: .regular))
                            if !viewModel.isAdmin {
                                Text(viewModel.studentRole)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.AssetIn.orange)
                            }else {
                                Text(viewModel.adminRole)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.AssetIn.orange)
                            }
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.horizontal)
                
                
            }
            .padding()
            .padding(.vertical)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(20)
            .padding(30)
            .shadow(color: .black.opacity(0.08), radius: 10)
            
            Spacer()
            
            Button {
                withAnimation {
                    viewModel.loginStatus = 0
                }
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.white)
                    Text("Logout")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .semibold))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.AssetIn.yellow)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 5)
            }
            .padding()
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ProfileView(viewModel: .init(), navigator: .init())
}
