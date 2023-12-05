//
//  NotificationView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 04/12/23.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel: NotificationViewModel
    @ObservedObject var navigator: AppNavigator
    
    var body: some View {
        VStack(spacing: 15){
            HStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("What are you looking for?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 0) {
                HStack{
                    VStack(alignment : .leading, spacing : 2){
                        Text("Hi, \(viewModel.name)")
                            .font(.system(size: 17, weight: .semibold))
                        Text("NIS : \(viewModel.NIS)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.AssetIn.orange)
                    }
                    Spacer()
                    VStack(spacing : 2) {
                        Text("Siswa")
                        Text(viewModel.userclass)
                    }
                    .font(.system(size: 12, weight: .medium))
                    .padding(.horizontal, 15)
                    
                }
                .padding()
                .padding(.vertical, 10)
                .background(
                    Color.white
                        .cornerRadius(15)
                )
                .overlay(alignment: .topTrailing) {
                    Image.imageProfile
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(x: -25, y: -25)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing : -20){
                        ForEach(0...1, id:\.self) { index in
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(.AssetIn.greyText)
                                .padding(.vertical)
                                .padding()
                            
                            HStack {
                                Image.logoWink
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                    .padding(.horizontal)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(viewModel.timeNotification)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.AssetIn.greyText)
                                    
                                    Text(viewModel.textNotification)
                                        .font((.system(size: 15, weight: .medium)))
                                }
                                Spacer()
                                
                            }
                        }
                        
                    }
                    .padding(.vertical, -10)
                    
                    
                    VStack(spacing : -20){
                        ForEach(0...2, id:\.self) { index in
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(.AssetIn.greyText)
                                .padding(.vertical)
                                .padding()
                            
                            HStack  {
                                Image.logoWink
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                    .padding(.horizontal)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(viewModel.oldtimeNotification)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.AssetIn.greyText)
                                    
                                    Text(viewModel.waitNotification)
                                        .font((.system(size: 15, weight: .medium)))
                                    Text(viewModel.processNotification)
                                        .font((.system(size: 10, weight: .medium)))
                                        .foregroundColor(.AssetIn.orange)
                                }
                                Spacer()
                                
                            }
                            
                        }
                        
                    }
                    .padding(.vertical, -10)
                    
                    VStack(spacing : -20){
                        ForEach(0...2, id:\.self) { index in
                            Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(.AssetIn.greyText)
                                .padding(.vertical)
                                .padding()
                            
                            HStack  {
                                Image.logoWink
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width : 60, height : 60)
                                    .offset()
                                    .padding(.horizontal)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(viewModel.oldtimeNotification)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.AssetIn.greyText)
                                    
                                    Text(viewModel.waitNotification)
                                        .font((.system(size: 15, weight: .medium)))
                                    Text(viewModel.takeplaceNotification)
                                        .font((.system(size: 10, weight: .medium)))
                                        .foregroundColor(.AssetIn.orange)
                                }
                                
                                Spacer()
                                
                            }
                            
                        }
                        
                    }
                    .padding(.vertical, -10)
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
                .frame(height: 130)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(15)
                Spacer()
            }
                .ignoresSafeArea()
        )
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
}



#Preview {
    NotificationView(viewModel: .init(), navigator: .init())
}
