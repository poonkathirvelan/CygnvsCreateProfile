//
//  UserProfileDelegate.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import Foundation


//MARK: -  User Profile Delegates for communication

public protocol UserProfileDelegate: AnyObject {
    func didSubmitUserProfile(userProfile: UserProfileModel)
    func backtoParentClicked()
}


public protocol CreateUserProfileDelegate: AnyObject {
    func disMissUserProfileView(userProfile: UserProfileModel?)
}
