//
//  CygEmailField.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import SwiftUI

struct EmailField: View {
    @ObservedObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        TextField("Email", text: $viewModel.userProfile.email)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .keyboardType(.emailAddress)
    }
}

#Preview {
    EmailField()
}
