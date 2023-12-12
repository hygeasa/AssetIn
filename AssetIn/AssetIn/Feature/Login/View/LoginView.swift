//
//  LoginView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var navigator: AppNavigator
    
    @FocusState var focused: Int?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30 ) {
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                Text(viewModel.isRegister ? "Register" : "Login")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 5, content:{
                    Text("Let's Get Started")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text("Hello!")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.black)
                    
                    
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)
                
                VStack(alignment: .leading, spacing: 20, content:{
                    if viewModel.isRegister {
                        VStack(alignment: .leading, spacing: 5, content:{
                            Text("Username")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                            
                            TextField("Your username..", text: $viewModel.usernameText)
                                .font(.system(size: 11,  weight: .regular ))
                                .padding()
                                .background(focused == 3 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.AssetIn.orange, lineWidth: focused == 3 ? 1 : 0)
                                        .foregroundColor(.AssetIn.orange)
                                }
                                .cornerRadius(10)
                                .tag(3)
                                .focused($focused, equals: 3)
                            
                        })
                        
                        VStack(alignment: .leading, spacing: 5, content:{
                            Text("NIS")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                            
                            TextField("Your NIS", text: $viewModel.NISText)
                                .font(.system(size: 11,  weight: .regular ))
                                .padding()
                                .background(focused == 4 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.AssetIn.orange, lineWidth: focused == 4 ? 1 : 0)
                                        .foregroundColor(.AssetIn.orange)
                                }
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                                .tag(4)
                                .focused($focused, equals: 4)
                            
                        })
                    }
                    
                    VStack(alignment: .leading, spacing: 10, content:{
                        Text("Email")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                        
                        TextField("Your registered email..", text: $viewModel.emailText)
                            .font(.system(size: 11,  weight: .regular ))
                            .padding()
                            .background(focused == 1 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.AssetIn.orange, lineWidth: focused == 1 ? 1 : 0)
                                    .foregroundColor(.AssetIn.orange)
                            }
                            .cornerRadius(10)
                            .tag(1)
                            .focused($focused, equals: 1)
                        
                    })
                    
                    VStack(alignment: .leading, spacing: 10, content:{
                        Text("Password")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                        
                        SecureField("Your password..", text: $viewModel.passwordText)
                            .font(.system(size: 11,  weight: .regular ))
                            .padding()
                            .background(focused == 2 ? Color .AssetIn.yellow.opacity(0.08) :
                                            Color.AssetIn.grey)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.AssetIn.orange, lineWidth: focused == 2 ? 1 : 0)
                                    .foregroundColor(.AssetIn.orange)
                            }
                            .cornerRadius(10)
                            .tag(2)
                            .focused($focused, equals: 2)
                        
                    })
                    
                })
                .padding(.horizontal, 40)
                
                VStack(spacing: 8) {
                    Button {
                        navigator.navigate(to: .main( navigator))
                    } label: {
                        Text(viewModel.isRegister ? "Register" : "Login")
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .semibold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.AssetIn.orange)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5)
                    }
                    
                    HStack{
                        Text(viewModel.isRegister ? "Already have an account?" : "Don't have any account?" )
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.black)
                        
                        Button {
                            viewModel.isRegister.toggle()
                            viewModel.passwordText = ""
                        } label: {
                            Text(viewModel.isRegister ? "Login" : "Register")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.AssetIn.orange)
                                .underline()
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .frame(maxHeight: .infinity)
        .background(
            ZStack {
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
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            Button {
                navigator.back()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .foregroundColor(.AssetIn.orange)
                    .padding()
            }

        }
    }
}

#Preview {
    LoginView(viewModel: .init(), navigator: .init())
}
