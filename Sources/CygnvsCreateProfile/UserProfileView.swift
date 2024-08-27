//
//  UserProfileView.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import SwiftUI

public struct UserProfileView: View {
    
    @ObservedObject private var viewModel = UserProfileViewModel()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //For Keyboard
    @FocusState private var isFocused: Bool
    @State private var isKeyboardVisible = false
    
    init(viewModel: UserProfileViewModel = UserProfileViewModel(), showingImagePicker: Bool = false, inputImage: UIImage? = nil) {
        self.viewModel = viewModel
        self.showingImagePicker = showingImagePicker
        self.inputImage = inputImage
    }
    
    public var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    TextField("Name", text: $viewModel.userProfile.username)
                        .focused($isFocused)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $viewModel.userProfile.email)
                        .padding()
                        .focused($isFocused)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                    
                    
                    TextField("Phone Number", text: Binding(
                        get: {
                            viewModel.userProfile.phoneNumber
                        },
                        set: { newValue in
                            //10 Digit Ph Number - Max
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered.count <= 10 {
                                viewModel.userProfile.phoneNumber = filtered
                            }
                            if filtered.count > 10 {
                                //Have to stop input
                                hideKeyboard()
                            }
                        }
                    ))
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                    ZStack{
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            if let imageData = viewModel.userProfile.profileImage,
                               let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: $inputImage)
                            
                        }
                        .onChange(of: inputImage) { _ in
                            isFocused = false
                            loadImage() }
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue).frame(width: 30, height: 30))
                            .offset(x: 70, y: 65)
                    }
                    Button("Submit") {
                        viewModel.submitForm()
                    }
                    .disabled(!viewModel.isFormValid)
                    .padding()
                    .background(viewModel.isFormValid ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .font(.system(size: 10.0))
                    }
                }
                .padding()
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    isKeyboardVisible = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    isKeyboardVisible = false
                }
                //Padding for Keyboard Visibility
                .padding(.bottom, isKeyboardVisible ? 10 : 0)
            }
            .navigationTitle("Create User Profile")
            .navigationBarBackButtonHidden(false)
            .navigationBarItems(leading: Button(action: {
                viewModel.backNavi()
            }) {
                Image(systemName: "chevron.left") // Icon for back button
                    .foregroundColor(.blue)
                Text("Back")
            })
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.userProfile.profileImage = inputImage.jpegData(compressionQuality: 0.8)
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: - Preview


#Preview {
    UserProfileView()
}
