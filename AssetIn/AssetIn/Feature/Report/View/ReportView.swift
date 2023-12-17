//
//  ReportView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct ReportView: View {
    
    @ObservedObject var viewModel : ReportViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("Report")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            VStack {
                HStack(spacing:10) {
                    Text("Categories : ")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal, 30)
                    Text("(\(viewModel.category))")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.AssetIn.orange)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                        .padding(.horizontal, 30)
                }
                    
                HStack {
                       //pilihan category
                }
                .padding(.vertical, 10)
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.AssetIn.greyText)
                    .padding(.horizontal)
                Text("Jenis Barang")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.horizontal, 30)
                
                    
                
                                 
                                 
                
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
    ReportView(viewModel: .init(), navigator: .init())
}
