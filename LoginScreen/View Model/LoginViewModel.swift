//
//  LoginViewModel.swift
//  LoginScreen
//
//  Created by Admin on 27/08/21.
//

import Foundation

protocol LoginViewModelDelegate {
    func getValidationStatus(status: Bool)
}

class LoginViewModel {
    
    //MARK: - Stored Properties
    private var loginDetail =  LoginDetail()

    private var email = ""
    private var password = ""
    
    var delegate:LoginViewModelDelegate?
    
    var validation = LoginValidation()

    var validateInput:((_ status: LoginInputStatus, _ message: String)-> ())?
    
    func updateValue(from emailTxtFld: String?, passwordTxtFld: String?) {
        
        guard let email = emailTxtFld, let pass = passwordTxtFld  else {
            delegate?.getValidationStatus(status: false)
            return
        }
        
        var isInputDetailValid: Bool = true
            
        if (!self.validation.isEmailValid(emailID: email)) {
            isInputDetailValid = false
        }
        if (!self.validation.isPasswordvalid(For: pass)) {
            isInputDetailValid = false
        }
        
        loginDetail.email = email
        loginDetail.password = pass

        self.email = email
        self.password = pass

        delegate?.getValidationStatus(status: isInputDetailValid)
        
    }
    
    
    func validateInput(complitionHandler: ((_ status: LoginInputStatus, _ message: String)->(Void)) ) -> Void {
        
        if email.isEmpty && password.isEmpty {
            complitionHandler(.Empty, "Please provide username and password.")
        }
        
        if email.isEmpty {
            complitionHandler(.Empty, "Username field is empty.")
        }
        
        if password.isEmpty {
            complitionHandler(.Empty, "Password field is empty.")
        }
        
        let isValidateEmail = self.validation.isEmailValid(emailID: email)
        if (isValidateEmail == false){
            complitionHandler(.InCorrect, "Incorrect Email.")
        }
        
        let isValidatePass = self.validation.isPasswordvalid(For: password)
        if (isValidatePass == false) {
            complitionHandler(.InCorrect, "Incorrect Password")
        }
        
        if email == LoginDetail.masterEmail && password == LoginDetail.masterPassword {
            complitionHandler(.Correct, "Data Matched!!")

        } else {
            
            complitionHandler(.InCorrect, "Please provide correc username and password!")

        }
    }
    
}

extension LoginViewModel {
    
    enum LoginInputStatus {
        case Empty
        case Correct
        case InCorrect
    }
}
