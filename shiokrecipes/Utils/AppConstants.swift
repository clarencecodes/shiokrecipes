//
//  AppConstants.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 10/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//
// For reference: https://medium.com/better-programming/organizing-your-swift-global-constants-for-beginners-251579485046

import Foundation
import UIKit

struct Constants {
    struct Design {
        struct Color {
            
        }
        
        struct Image {
            
        }
        
        struct Font {
            static var newYorkBold: UIFont {
                /// 1. Initialize a system font with the preferred size and weight and access its `fontDescriptor` property.
                let descriptor = UIFont.systemFont(ofSize: 24,
                                                   weight: .bold).fontDescriptor
                
                /// 2. Use the new iOS13 `withDesign` to get the `UIFontDescriptor` for a serif version of your system font. The size is derived from your initial `UIFont` so set it to `0.0`
                if let serif = descriptor.withDesign(.serif) {
                    return UIFont(descriptor: serif, size: 0.0)
                }
                
                /// 3. Initialize a font with the serif descriptor of your system font. Again: use `0.0` as `size` parameter to prevent overriding the initial size we did set above.
                return UIFont(descriptor: descriptor, size: 0.0)
            }
            
            static var newYorkSemibold: UIFont {
                let descriptor = UIFont.systemFont(ofSize: 24,
                                                   weight: .semibold).fontDescriptor
                if let serif = descriptor.withDesign(.serif) {
                    return UIFont(descriptor: serif, size: 0.0)
                }
                return UIFont(descriptor: descriptor, size: 0.0)
            }
            
            static var newYorkMedium: UIFont {
                let descriptor = UIFont.systemFont(ofSize: 24,
                                                   weight: .medium).fontDescriptor
                if let serif = descriptor.withDesign(.serif) {
                    return UIFont(descriptor: serif, size: 0.0)
                }
                return UIFont(descriptor: descriptor, size: 0.0)
            }
            
            static var newYorkRegular: UIFont {
                let descriptor = UIFont.systemFont(ofSize: 24,
                                                   weight: .regular).fontDescriptor
                if let serif = descriptor.withDesign(.serif) {
                    return UIFont(descriptor: serif, size: 0.0)
                }
                return UIFont(descriptor: descriptor, size: 0.0)
            }
        }
    }
    
    struct Content {
        static let welcomeText = "Welcome,\nsign in to continue"
        static let emailOrUsername = "email or username"
        static let password = "password"
        static let signUpGetStartedText = "Sign up\nto get started"
        static let firstName = "first name"
        static let lastName = "last name"
        static let email = "email"
        static let username = "username"
        static let confirmPassword = "confirm password"
    }
    
    
}