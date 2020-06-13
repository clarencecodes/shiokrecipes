//
//  Helper.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 13/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class Helper {
    static let app = Helper()
    
    func showMessagePrompt(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
