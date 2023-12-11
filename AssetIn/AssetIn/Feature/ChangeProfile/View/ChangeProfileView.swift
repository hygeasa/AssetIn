//
//  ChangeProfileView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI
struct ChangeProfileView: View {
    @ObservedObject var viewModel : ChangeProfileViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack(spacing: 20){
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
            
            Image.elipseprofile
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottomTrailing) {
                    Image.changephoto
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .offset(x: -40, y: -30)
                }
                .frame(width: 200)
                .padding()
                
            
            Text("Change Profile")
                .font(.system(size: 13, weight: .semibold))
            
            Button {
                viewModel.isChangeSuccess = true
            }label: {
                Text("Save")
                    .foregroundColor(.white)
                    .font(.system(size: 13, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.AssetIn.yellow)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 5)
                    .padding(.vertical)
            }
            .padding()
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 5)
        .padding()
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .alert(isPresented: $viewModel.isChangeSuccess, content: {
            Alert(title: Text("Yeay!"), message: Text("Profile Picture Update Complete!"), dismissButton: .default(Text("Okay"), action: {
                navigator.back()
            }))
        })
    }
}

#Preview {
    ChangeProfileView(viewModel: .init(), navigator: .init())
}
