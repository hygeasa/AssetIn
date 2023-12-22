//
//  FindReportView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct FindReportView: View {
    
    @ObservedObject var viewModel : FindReportViewModel
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
                Text(viewModel.date, style: .date)
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
            
            ScrollView{
                VStack {
                    ForEach(viewModel.historyData, id:\.id) { item in
                        VStack(alignment: .leading, spacing: 5){
                            Text(item.status ?? "–")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .foregroundColor(viewModel.statusColor(item.status ?? ""))
                                )
                            
                            Text(item.inventoryName ?? "–")
                                .font(.system(size: 15, weight: .regular))
                            
                            Group {
                                Text("from \(item.studentName ?? "") (\(item.studentNIS ?? ""))")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.AssetIn.purple)
                                    .padding(.top, 5)
                                
                                HStack(spacing: 0) {
                                    Text("Requested: ")
                                    Text((item.requestedAt?.toString(format: .withSlash)) ?? "–")
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Borrowed: ")
                                    Text((item.borrowedAt?.toString(format: .withSlash)) ?? "–")
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Returned: ")
                                    Text((item.returnedAt?.toString(format: .withSlash)) ?? "–")
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Expired: ")
                                    Text((item.expiredAt?.toString(format: .withSlash)) ?? "–")
                                }
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.AssetIn.orange)
                            }
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.AssetIn.greyText)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
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
        .onAppear {
            viewModel.getHistoryData()
        }
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    FindReportView(viewModel: .init(date: .now), navigator: .init())
}
