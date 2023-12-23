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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Categories: ")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.horizontal, 30)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.categories.indices, id:\.self) { index in
                                let item = viewModel.categories[index]
                                
                                Button {
                                    withAnimation {
                                        viewModel.categories[index].isSelected.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text(item.name)
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(item.isSelected ? .white : .AssetIn.orange)
                                        
                                        if item.isSelected {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding(6)
                                    .padding(.horizontal, 8)
                                    .background(item.isSelected ? Color.AssetIn.orange : Color.AssetIn.greyChecklist.opacity(0.5))
                                    .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.AssetIn.greyText)
                        .padding(.horizontal)
                    
                    DatePicker(
                        "",
                        selection: $viewModel.date,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .tint(Color.AssetIn.orange)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.08), radius: 8)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Button {
                navigator.navigate(to: .findReport(.init(date: viewModel.date, filter: viewModel.filter), navigator))
            }label: {
                Text("Find Report")
                    .foregroundColor(.white)
                    .font(.system(size: 13, weight: .semibold))
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
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ReportView(viewModel: .init(), navigator: .init())
}
