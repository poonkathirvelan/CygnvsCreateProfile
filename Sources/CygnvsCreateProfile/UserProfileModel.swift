//
//  UserProfileModel.swift
//  
//
//  Created by Poonkathirvelan Boopalan on 27/08/24.
//

import Foundation

//MARK: - Date Model for Profile View

public struct UserProfileModel {
  public  var username: String = ""
  public  var email: String = ""
  public  var phoneNumber: String = ""
  public  var imageData: Data?
  public  var profileImage: Data? = nil
}
