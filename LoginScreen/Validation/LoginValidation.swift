//
//  LoginValidation.swift
//  LoginScreen
//
//  Created by Admin on 26/08/21.
//

import Foundation


struct ValidationResult {
    var success: Bool = false
    var errorMessage: String?
}

struct LoginValidation {
    
    //MARK: - Validate the Email
    func isEmailValid(emailID: String) -> Bool {
        
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
          let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          let isValidateEmail = validateEmail.evaluate(with: trimmedString)
          return isValidateEmail
       }
   
    //MARK: - Validate the Password
    //Minimum 5 characters at least 1 special character

    func isPasswordvalid(For password: String) -> Bool {
        if password.isEmpty {
            return false
        }
        let trimmedString = password.trimmingCharacters(in: .whitespaces)

        if trimmedString.count >= 5 && isContainSpecialCharacter(For: trimmedString) {
            return true
        }
    
        return false
    }
    
    //MARK: - Check for Special Character

    func isContainSpecialCharacter(For searchTerm: String) -> Bool  {
        do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
                if let _ = regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, searchTerm.count)) {
                    return true
                }

            } catch {
                debugPrint(error.localizedDescription)
                return false
            }

            return false
    }
    
}

