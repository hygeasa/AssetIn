//
//  AcceptRequestBottomSheet.swift
//  AssetIn
//
//  Created by Irham Naufal on 21/12/23.
//

import SwiftUI

struct AcceptRequestBottomSheet: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @FocusState var focused: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        viewModel.resetCurrentRequestData()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Request")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.clear)
                }
                .padding(8)
                Divider()
            }
            
            ScrollView {
                VStack(spacing: 18) {
                    Text("\(viewModel.currentRequest?.studentName ?? "–") (\(viewModel.currentRequest?.studentNIS ?? "–"))")
                        .font(.system(size: 22,  weight: .semibold ))
                        .foregroundColor(.AssetIn.purple)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Inventory Name")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(viewModel.currentRequest?.inventoryName ?? "–")
                            .font(.system(size: 12,  weight: .regular ))
                            .foregroundColor(.AssetIn.greyText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.AssetIn.greyChecklist.opacity(0.8))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading) {
                                Text("Quantity")
                                    .font(.system(size: 14, weight: .semibold))
                                
                                TextField("0", text: $viewModel.currentQuantity)
                                    .font(.system(size: 12,  weight: .regular ))
                                    .tint(.AssetIn.orange)
                                    .keyboardType(.numberPad)
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
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Available Stock")
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text("\(viewModel.currentStock)")
                                    .font(.system(size: 12,  weight: .regular ))
                                    .foregroundColor(.AssetIn.greyText)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.AssetIn.greyChecklist.opacity(0.8))
                                    .cornerRadius(10)
                            }
                        }
                        
                        Group {
                            if viewModel.isOutOfStock {
                                Text("*the quantity must be less than the stock")
                            } else if viewModel.isQuantityZero {
                                Text("*the quantity can't be 0")
                            }
                        }
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.red)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Take Place")
                            .font(.system(size: 14, weight: .semibold))
                        
                        TextField("Tata Usaha...", text: $viewModel.takePlace)
                            .font(.system(size: 12,  weight: .regular ))
                            .tint(.AssetIn.orange)
                            .padding()
                            .background(focused == 2 ? Color.AssetIn.yellow.opacity(0.08) : Color.AssetIn.grey)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.AssetIn.orange, lineWidth: focused == 2 ? 1 : 0)
                                    .foregroundColor(.AssetIn.orange)
                            }
                            .cornerRadius(10)
                            .tag(2)
                            .focused($focused, equals: 2)
                    }
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            Button {
                viewModel.acceptRequest()
            } label: {
                Text("Accept")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(viewModel.acceptButtonDisabled ? .AssetIn.greyChecklist : .AssetIn.orange)
                    )
                    .padding()
            }
            .disabled(viewModel.acceptButtonDisabled)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(isPresented: $viewModel.isAccepted) {
            Alert(
                title: Text("Success"),
                message: Text("The request has been accepted"),
                dismissButton: .default(Text("Okay"), action: {
                    viewModel.resetCurrentRequestData()
                })
            )
        }
    }
}

#Preview {
    AcceptRequestBottomSheet(viewModel: .init())
}
