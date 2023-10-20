//
//  Utilities.swift
//  collection
//
//  Created by Larissa Lanes on 15/09/23.
//

import Foundation

class Utilities {
    static func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordTest.evaluate(with: password)
    }
}
