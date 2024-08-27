//
//  UserProfileViewModel.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//


import Combine
import Foundation

public class UserProfileViewModel: ObservableObject {
    
   public var profilePublisher = PassthroughSubject<UserProfileModel, Never>()

    public var backPublisher = PassthroughSubject<String, Never>()
    
    @Published  var userProfile = UserProfileModel()
        @Published  var errorMessage: String = ""
        @Published   var isFormValid: Bool = false

        private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: UserProfileDelegate?

      public  init() {
            $userProfile
                .sink { [weak self] profile in
                    self?.validateForm(profile: profile)
                }
                .store(in: &cancellables)
        }

        func validateForm(profile: UserProfileModel) {
            if profile.username.isEmpty {
                errorMessage = "Please enter your Name"
                isFormValid = false
            } else if !isValidEmail(profile.email) {
                errorMessage = "Please enter a valid email Id"
                isFormValid = false
            } else if !isValidPhoneNumber(profile.phoneNumber) {
                errorMessage = "Please enter a 10 digit phone number"
                isFormValid = false
            } else if profile.profileImage == nil {
                errorMessage = "Profile image is required."
                isFormValid = false
            } else {
                errorMessage = ""
                isFormValid = true
            }
        }

        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
        }

        private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
            let phoneRegEx = "^[0-9]{10}$"
            return NSPredicate(format: "SELF MATCHES %@", phoneRegEx).evaluate(with: phoneNumber)
        }

        func submitForm() {
            if isFormValid {
                // Handle form submission
                print("Form Submitted: \(userProfile)")
                delegate?.didSubmitUserProfile(userProfile: userProfile)
                profilePublisher.send(userProfile)
            }
        }
    
    func backNavi(){
        delegate?.backtoParentClicked()
        backPublisher.send("back")
    }
}
