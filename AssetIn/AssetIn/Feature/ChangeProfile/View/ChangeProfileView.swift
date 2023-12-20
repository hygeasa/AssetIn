//
//  ChangeProfileView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI
import PhotosUI

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
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                Image.elipseprofile
                    .resizable()
                    .scaledToFit()
                Group {
                    if viewModel.imagePlaceholder == UIImage() {
                        if let imageURL = viewModel.userData?.imageURL {
                            AsyncImage(url: URL(string: imageURL)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                    } else {
                        Image(uiImage: viewModel.imagePlaceholder)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    viewModel.isShowImagePicker = true
                } label: {
                    Image.changephoto
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
                .offset(x: -40, y: -30)
            }
            .frame(width: 200)
            .padding()
            
            Text("Change Profile")
                .font(.system(size: 13, weight: .semibold))
            
            Button {
                viewModel.uploadImage()
            } label: {
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
            .disabled(viewModel.buttonDisabled)
            .padding()
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 5)
        .padding()
        .onAppear {
            viewModel.getUserData()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.white)
                }
                .ignoresSafeArea()
            }
        }
        .alert(isPresented: $viewModel.isShowAlert, content: {
            Alert(title: Text(viewModel.isError ? "Oops.." : "Yeay!"), message: Text(viewModel.isError ? viewModel.errorText : "Profile Picture Update Complete!"), dismissButton: .default(Text("Okay"), action: {
                navigator.back()
            }))
        })
        .photosPicker(
            isPresented: $viewModel.isShowImagePicker,
            selection: $viewModel.selectedImage,
            matching: .images
        )
        .onChange(of: viewModel.selectedImage) { _ in
            Task {
                await viewModel.changeImagePlaceholder()
            }
        }
    }
}

#Preview {
    ChangeProfileView(viewModel: .init(), navigator: .init())
}
