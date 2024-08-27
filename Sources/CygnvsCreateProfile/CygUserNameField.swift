//
//  CygUserNameField.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import SwiftUI

struct UserNameField: View {
    @ObservedObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        TextField("Name", text: $viewModel.userProfile.username)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

#Preview {
    UserNameField()
}
