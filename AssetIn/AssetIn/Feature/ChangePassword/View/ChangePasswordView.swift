//
//  ChangePasswordView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 07/12/23.
//

import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var viewModel: ChangePasswordViewModel
    @ObservedObject var navigator: AppNavigator
    
    @FocusState var focused: Int?
    
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                }
                .padding(.top, 30)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                
                VStack (alignment: .center,spacing: 25) {
                    Image.resetpassword
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    
                    Text("Reset Password")
                        .font(.system(size: 15, weight: .semibold))
                    
                            Text("Enter your new password, use different password than before.")
                                .font(.system(size: 12, weight: .regular))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                }
                .padding(.vertical, 25)
                
                VStack {
                    
                    VStack(alignment: .leading, spacing: 5, content:{
                        Text("New Password")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                        
                        SecureField("Your new password", text: $viewModel.passwordText)
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
                            .padding(.vertical, 10)
                        
                        VStack(alignment: .leading, spacing: 5, content:{
                            Text("Confirm Password")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                            
                            SecureField("Confirm your new password..", text: $viewModel.confirmPasswordText)
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
                                .padding(.top, 10)
                                .padding(.bottom, viewModel.passwordNotMatch ? 0 : 10)
                            
                            if viewModel.passwordNotMatch {
                                Text("*your password doesn't match")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.red)
                                    .padding(.bottom, 10)
                            }
                        })

                        Button {
                            viewModel.changePassword()
                        }label: {
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .semibold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.buttonDisabled ? Color.AssetIn.greyChecklist : Color.AssetIn.yellow)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 5)
                                .padding(.vertical)
                        }
                        .padding(.vertical, 10)
                        .disabled(viewModel.buttonDisabled)
                    })
                    
                }
                .padding(.horizontal, 20)
                
            }
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 5)
            .padding()
        }
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.isShowAlert, content: {
            Alert(
                title: Text(viewModel.isError ? "Oopss.." : "Yeay!"),
                message: Text(viewModel.isError ? viewModel.errorText : "Password Update Complete!"),
                dismissButton: .default(Text("Okay"), action: {
                navigator.back()
            }))
        })
    }
}

#Preview {
    ChangePasswordView(viewModel: .init(), navigator: .init())
}
