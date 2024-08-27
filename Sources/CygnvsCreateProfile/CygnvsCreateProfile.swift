// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import SwiftUI
import Combine

public class CygnvsCreateProfile: NSObject  {
    
    public static let shared = CygnvsCreateProfile()
    private override init() {
        super.init()
    }
    var text = "Welcome to Cygnvs"
    public weak var delegate: CreateUserProfileDelegate?
    
    //MARK: - Test for SPM
    
    public func testSPM()  {
        print(text)
    }
    
    //MARK: - Use this method for UIKIT project
    
    public func loadUserProfileView() -> some View {
        let viewModel = UserProfileViewModel()
        viewModel.delegate = self
        return UserProfileView(viewModel: viewModel)
    }
    
    //MARK: - User this method for SWIFTUI
    
    public func loadUserProfileViewforSwiftUI(model: UserProfileViewModel) -> some View {
        return UserProfileView(viewModel: model)
    }
    
}

//MARK: - UserProfileDelegate for Back and Submit

extension CygnvsCreateProfile: UserProfileDelegate {
    //BACK
    public func backtoParentClicked() {
        self.delegate?.disMissUserProfileView(userProfile: nil)
    }
    //SUBMIT
    public func didSubmitUserProfile(userProfile: UserProfileModel) {
        print(userProfile)
        self.delegate?.disMissUserProfileView(userProfile: userProfile)
    }
}
