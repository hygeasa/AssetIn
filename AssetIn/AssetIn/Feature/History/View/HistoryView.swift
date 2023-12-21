//
//  HistoryView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel : HistoryViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navigator.back()
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("History")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
            }
            .padding(.horizontal)
            
            Group {
                if viewModel.historyData.isEmpty {
                    HistoryEmptyView(navigator: navigator)
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.historyData, id:\.id) { item in
                                VStack(alignment: .leading, spacing: 5){
                                    Text(item.status ?? "–")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .medium))
                                        .padding(6)
                                        .padding(.horizontal)
                                        .background(Color.AssetIn.green)
                                        .cornerRadius(15)
                                    
                                    Text(item.inventoryName ?? "–")
                                        .font(.system(size: 15, weight: .regular))
                                    
                                    Text("Category: \((item.categoryId ?? "–").capitalized)")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                    Group {
                                        if let returnedAt = item.returnedAt {
                                            Text("Returned: \(returnedAt.toString(format: .withSlash))")
                                        } else {
                                            Text("Returned: –")
                                        }
                                    }
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.AssetIn.greyText)
                                    
                                    Button {
                                        viewModel.isShowAlert = true
                                    } label: {
                                        Text("Borrow Again")
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(.black)
                                            .padding(8)
                                            .padding(.horizontal, 5)
                                            .background(
                                                Capsule()
                                                    .foregroundColor(.AssetIn.yellow)
                                            )
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal)
                                .alert("Borrow this item again?", isPresented: $viewModel.isShowAlert) {
                                    TextField("0", text: $viewModel.quantity)
                                        .keyboardType(.numberPad)
                                    
                                    Button(role: .cancel) {
                                        
                                    } label: {
                                        Text("Back")
                                    }
                                    
                                    Button() {
                                        viewModel.requestBorrow(item)
                                    } label: {
                                        Text("Add")
                                    }
                                } message: {
                                    Text("")
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .onAppear {
            viewModel.getHistoryData()
            viewModel.getUserData()
        }
        .alert(isPresented: $viewModel.isRequest, content: {
            Alert(title: Text("Thank you"), message: Text("Your request will be process soon!"), dismissButton: .default(Text("Okay")))
        })
    }
}

#Preview {
    HistoryView(viewModel: .init(), navigator: .init())
}
