//
//  HistoryView.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                    mainContent
                }
            }
            .refreshable {
                viewModel.onAppear()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.onAppear()
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isShowAlert, actions: {
            Button("Okay") {}
        }, message: {
            Text(viewModel.alertMessage)
        })
    }
}

extension HistoryView {
    @ViewBuilder
    var header: some View {
        HeaderView {
            Text("History")
                .font(.headline)
                .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    var mainContent: some View {
        Section {
            if viewModel.loans.isEmpty {
                DefaultEmptyView()
            } else {
                ForEach(viewModel.loans) { loan in
                    HStack(alignment: .top, spacing: 8) {
                        AsyncImage(url: URL.imagePath((loan.inventory?.photo).orEmpty())) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text((loan.status?.rawValue).orEmpty())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 12)
                                .background(Capsule().fill(viewModel.statusColor(loan.status)))
                            
                            Text((loan.inventory?.name).orEmpty())
                                .font(.headline)
                            
                            Text(loan.status?.rawValue == "REQUEST" ? "Still processing.." : "📍 \(loan.pickupLocation.orEmpty())"
                            )
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.AssetIn.greyText)
                            
                            Text("⏰ \((loan.dueDate?.dateDisplay(.slash)).orEmpty())")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.AssetIn.orange)
                                .padding(.top, 1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .strokeBorder(Color.AssetIn.greyChecklist, lineWidth: 0.5)
                    }
                }
                .padding(.horizontal)
            }
        } header: {
            contentHeader
        }
    }
    
    @ViewBuilder
    var contentHeader: some View {
        HStack {
           Image(systemName: "slider.horizontal.3")
                .font(.headline)
                .foregroundStyle(Color.AssetIn.orange)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(LoanStatus.allCases) { status in
                        Button {
                            viewModel.getLoanHistory(status: status)
                        } label: {
                            Text(status.rawValue.capitalized)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background {
                                    Capsule()
                                        .fill(viewModel.status == status ? Color.AssetIn.orange.opacity(0.2) : Color.AssetIn.greyChecklist.opacity(0.5))
                                }
                                .overlay {
                                    if viewModel.status == status {
                                        Capsule()
                                            .inset(by: 0.5)
                                            .strokeBorder(Color.AssetIn.orange)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(.vertical, 8)
        .background(.white)
    }
}

#Preview {
    HistoryView()
}
