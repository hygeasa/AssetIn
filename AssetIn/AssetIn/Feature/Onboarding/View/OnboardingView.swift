//
//  OnboardingView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var navigator: AppNavigator
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Image.logoWithText
                .resizable()
                .scaledToFit()
                .frame(width: 262)
            
            Image.logoAssetin
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            VStack(alignment: .leading, spacing: 18, content: {
                Text("Welcome to AssetIn")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                Button {
                    navigator.navigate(to: .login(.init(isAdmin: false), navigator))
                } label: {
                    Text("Sign in as student")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.AssetIn.yellow)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5)
                }
                
                Button {
                    navigator.navigate(to: .login(.init(isAdmin: true), navigator))
                } label: {
                    Text("Sign in as admin")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.AssetIn.orange)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5)
                }
            })
            .padding(.horizontal, 40)
        }
        .frame(maxHeight: .infinity)
        .background(
            ZStack {
                Color.AssetIn.bg
                
                VStack {
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.AssetIn.orange.opacity(0.3))
                                .frame(width: 184, height: 184)
                                .offset(x: 92, y: -30)
                            
                            Circle()
                                .foregroundColor(.AssetIn.orange.opacity(0.3))
                                .frame(width: 184, height: 184)
                                .offset(y: -92)
                        }
                        .blur(radius: 5)
                    }
                    
                    Spacer()
                    
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.AssetIn.orange.opacity(0.3))
                                .frame(width: 184, height: 184)
                                .offset(x: -92, y: 30)
                            
                            Circle()
                                .foregroundColor(.AssetIn.orange.opacity(0.3))
                                .frame(width: 184, height: 184)
                                .offset(y: 92)
                        }
                        .blur(radius: 5)
                        
                        Spacer()
                    }
                }
            }
                .ignoresSafeArea()
        )
        .navigationTitle("")
        .onAppear {
            if loginStatus != 0 {
                navigator.navigate(to: .main(navigator))
            }
        }
    }
}

#Preview {
    OnboardingView(navigator: .init())
}
