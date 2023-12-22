//
//  EditItemView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct EditItemView: View {
    @ObservedObject var viewModel : EditItemViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("Edit item")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            VStack{
                HStack {
                    ForEach(0...2, id :\.self)  {index in
                        AsyncImage(url: URL(string:"https://cdn.antaranews.com/cache/1200x800/2023/06/18/IMG-20230618-WA0002_2.jpg"))
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .padding(.vertical)
                
                VStack(spacing: 10) {
                    Text("Type")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.AssetIn.greyText)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal)
                    
                    TextField("Item Type..", text: $viewModel.category)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.AssetIn.greyText)
                        .padding(.horizontal)
                    
                    
                }
                
                VStack(spacing: 10) {
                    Text("Stock")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.AssetIn.greyText)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal)
                    
                    TextField("0", text: $viewModel.stock)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.AssetIn.greyText)
                        .padding(.horizontal)
                }
                .padding(.vertical)
                Spacer()
                
                VStack(spacing: 10){
                    Button {
                        
                    }label: {
                        Text("Update product")
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .semibold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.AssetIn.yellow)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        
                    }label: {
                        Text("Remove product")
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .semibold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5)
                    }
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(20)
            .padding(30)
            .shadow(color: .black.opacity(0.08), radius: 10).background(Color.white)
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
    EditItemView(viewModel: .init(), navigator: .init())
}
