//
//  ProfileInputCell.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import SwiftUI

struct ProfileInputCell: View {
    var inputType: InputType
    @Binding var text: String
    @Binding var error: String?
    var isDoneButton: Bool
    var keyboardType: UIKeyboardType
    //Creating custom cell to reuse
    var body: some View {
        VStack(alignment: .leading) {
            TextField(inputType.placeholder, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            
            if let error = error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
        }
        .padding()
    }
}

enum InputType {
    case name
    case email
    case phoneNumber
    
    var placeholder: String {
        switch self {
        case .name: return "Name"
        case .email: return "Email"
        case .phoneNumber: return "Phone Number"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name: return .default
        case .email: return .emailAddress
        case .phoneNumber: return .numberPad
        }
    }
}

#Preview {
    ProfileInputCell(
        inputType: .email,
        text: .constant(""),
        error: .constant(nil),
        isDoneButton: false,
        keyboardType: .emailAddress
    )
}
