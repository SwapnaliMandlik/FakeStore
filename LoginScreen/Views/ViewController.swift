//
//  ViewController.swift
//  LoginScreen
//
//  Created by Admin on 18/08/21.
//

import UIKit


/***~~~ Login Scene ~~~*/

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblLogin: UIButton!
    
    
    // MARK: - Stored Properties
    var loginViewModel = LoginViewModel()
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLogin.backgroundColor = UIColor.gray

        setDelegates()
    }
    
    //tohide the Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // to get the navigation Bar in the next view Controller
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - IBActions
    
    @IBAction func onClickLogin(_ sender: Any) {
       
       // self.OpenHome()
        
        
   //     return
            
        loginViewModel.updateValue(from: txtEmail.text, passwordTxtFld: txtPassword.text)
        //validate of Login details
        loginViewModel.validateInput { status, message in
            if status == .Correct {
                self.OpenHome()
            } else {
                self.showAlert(msg: message, status: status)
            }
        }
        
        
    }
    
    //MARK: - Show Alert Message
    
    func showAlert(msg: String, status: LoginViewModel.LoginInputStatus)  {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.destructive) { action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - Open Home Scene
    func OpenHome()  {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let nav  = UINavigationController.init(rootViewController: vc)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nav)
    }
    
    
}

//MARK: - Text Field Delegate Methods

extension ViewController: UITextFieldDelegate {
    
    func setDelegates()  {
        txtEmail.delegate = self
        txtPassword.delegate = self
        loginViewModel.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
    
    
}

//MARK: - Login View model Delegate Methods

extension ViewController: LoginViewModelDelegate {
    
    func getValidationStatus(status: Bool) {
        
//        if status {
//            lblLogin.backgroundColor = UIColor.blue
//            lblLogin.isEnabled = true
//
//        } else {
//            lblLogin.backgroundColor = UIColor.gray
//            lblLogin.isEnabled = false
//
//        }

    }
}
