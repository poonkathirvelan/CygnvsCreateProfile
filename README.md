
#  Cygnvs - CreateUserProfile Swift Package

## Overview

The `CygnvsCreateUserProfile` Swift Package provides a user profile creation UI component that can be integrated into both UIKit and SwiftUI projects. This package includes fields for Username, Phone Number, Email, and an Image Picker. It also supports Combine for reactive programming in SwiftUI and uses a delegate pattern for communication between the package and the parent app.

## Features

- **Username Field**: A text input for entering the user's username.
- **Phone Number Field**: A text input for entering the user's phone number with validation.
- **Email Field**: A text input for entering the user's email address with validation.
- **Image Picker**: Allows the user to select a profile picture from their gallery.
- **Validation**: Includes basic validation for Username, Phone Number, and Email.
- **Combine Support**: For integration with SwiftUI using Combine.
- **Delegate Pattern**: For communication with UIKit projects.

## Installation

### Using Swift Package Manager

Add the package to your Xcode project using Swift Package Manager:

1. Open your Xcode project.
2. Navigate to `File` > `Add Packages`.
3. Enter the URL of the `https://github.com/poonkathirvelan/CygnvsCreateProfile` repository.
4. Select 'main' branch to use and click `Add Package`.


## Usage

### UIKit Integration

1. **Add the Package to Your UIKit Project**: Follow the installation steps mentioned above.

2. **Use the `MyLibraryT` Class**:

   ```swift
   import UIKit
   import CygnvsCreateProfile

   class ViewController: UIViewController, UserProfileDelegate {

      private var hostingController: UIHostingController<UserProfileView>?

       override func viewDidLoad() {
           super.viewDidLoad()
           userProfile.delegate = self
       }

       func createProfil(){
          let userProfileView = CygnvsCreateProfile.shared.loadUserProfileView()
        hostingController = UIHostingController(rootView: userProfileView as! UserProfileView)
        if let hostingController = hostingController {
                   addChild(hostingController)
                   view.addSubview(hostingController.view)

                   //Add Constraints if needed

                   hostingController.didMove(toParent: self)
               }
           CygnvsCreateProfile.shared.delegate = self

        }
       //Delegate
       func disMissUserProfileView(userProfile: UserProfileModel?) {
         // Remove Host Controller
         // use Profile Model for display or API
       }
   }
   ```

   Implement the `CreateUserProfileDelegate` methods to receive profile data.



### SwiftUI Integration

1. **Add the Package to Your SwiftUI Project**: Follow the installation steps mentioned above.

2. **Use the `CygnvsCreateProfile` Class**:

   ```swift
   import SwiftUI
   import CygnvsCreateProfile
 
   struct ContentView: View {

      @StateObject private var viewModel = UserProfileViewModel()

       var body: some View {
           VStack {
               CygnvsCreateProfile.shared.loadUserProfileViewforSwiftUI(model: viewModel )
                          .onReceive(viewModel.profilePublisher) { profile in
   
                              //use Profile Model for display or API
                          }
                          .onReceive(viewModel.backPublisher, perform: { _ in
                              //Dismiss View 
                          })
           }
       }
   }
   ```

   


## Configuration



## Examples

For detailed examples and use cases, please refer to the `Example` directory in the repository.

## Contributing


## License



## Contact

For any questions or issues, please contact:

- **Author**: Kathir
- **Email**: poonkathirvelan.vite@gmail.com

---

Feel free to adjust any details to better fit your project!
