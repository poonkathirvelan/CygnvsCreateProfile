//
//  CygPhoneNumberField.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import SwiftUI

struct PhoneNumberField: View {
    @ObservedObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
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
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    PhoneNumberField()
}

