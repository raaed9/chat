//
//  ViewController.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 13/10/1443 AH.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabelOutlet.text = ""
        passwordLabelOutlet.text = ""
        confirmPasswordLabelOutlet.text = ""
        
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
        confirmPasswordTextFieldOutlet.delegate = self
        
        
        setupBagroundTap()
        // Do any additional setup after loading the view.
    }

    //MARK: Variables
    
    var isLogin: Bool = false
    
   //MARK: IBOutlets
    
      //Labels
    
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var confirmPasswordLabelOutlet: UILabel!
    @IBOutlet weak var haveAnAccountLabelOutlet: UILabel!
    
      //TextFields
    
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    
    //MARK: Button Outlet
    
    @IBOutlet weak var forgetPasswordOutlet: UIButton!
    @IBOutlet weak var resendEmailOutlet: UIButton!
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    
    
    
    //MARK: IBAction
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
       
        if isDateInputedFor(mode: "forgetPassword") {
            print("all data inputed correctly")
            
            forgetPassword()
            
        } else {
            ProgressHUD.showError("All fields are required")
        }
        
    }
    
    
    @IBAction func resendEmailPressed(_ sender: UIButton) {
        print("resendEmailPressed")
        
        resendVerficationEmail()
        
        
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {

        if isDateInputedFor(mode: isLogin ? "login" : "register") {
            
            isLogin ? loginUser() : registerUser()
            
             //TODO: LOGIN or Register
            
            
            //Register
            

            
            
            
        } else {
            ProgressHUD.showError("All fields are required")
        }
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {

        updateUIMode(mode: isLogin)
    }
    
    
    private func updateUIMode(mode: Bool) {
        
        if !mode {
            titleOutlet.text = "Login"
            confirmPasswordLabelOutlet.isHidden = true
            confirmPasswordTextFieldOutlet.isHidden = true
            registerOutlet.setTitle("Login", for: .normal)
            loginOutlet.setTitle("Register", for: .normal)
            haveAnAccountLabelOutlet.text = "New here?"
            forgetPasswordOutlet.isHidden = false
            resendEmailOutlet.isHidden = true
        } else {
            titleOutlet.text = "Register"
            confirmPasswordLabelOutlet.isHidden = false
            confirmPasswordTextFieldOutlet.isHidden = false
            registerOutlet.setTitle("Register", for: .normal)
            loginOutlet.setTitle("Login", for: .normal)
            haveAnAccountLabelOutlet.text = "Have an account?"
            forgetPasswordOutlet.isHidden = true
            resendEmailOutlet.isHidden = false
        }
        
        isLogin.toggle()
    }
    
    
    //MARK: Helpers Or Utilities
    
    private func isDateInputedFor (mode: String) ->Bool {
        
        switch mode {
        case "login":
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != ""
        case "register":
            return emailTextFieldOutlet.text != "" && passwordTextFieldOutlet.text != nil
            && confirmPasswordTextFieldOutlet.text != ""
        case "forgetPassword":
            return emailTextFieldOutlet.text != ""
        default:
            return false
        }
        
        
    }
    
    
    //MARK: Tap Gesture Recognizer
    
    private func setupBagroundTap() {
        
        let tapGesture =  UITapGestureRecognizer (target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard () {
        view.endEditing(false)
    }
    
    
    //MARK: Forget password
    
    private func forgetPassword () {
        FUserListener.shared.resetPasswordFor(email: emailTextFieldOutlet.text!) { error in
            if error == nil {
                ProgressHUD.showSucceed("Reset password email has been sent")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
        //MARK: Register User
    
    private func registerUser () {
        
            
            if passwordTextFieldOutlet.text! == confirmPasswordTextFieldOutlet.text! {
                FUserListener.shared.registerUserWith(email: emailTextFieldOutlet.text!, password: passwordTextFieldOutlet.text!) { error in
                    
                    if error == nil {
                        ProgressHUD.showSucceed("Verifcation email sent, please verify your email and confirm the registeration")
                    } else {
                        ProgressHUD.showError(error!.localizedDescription)
                    }
                }
            }
            
        
    }
    
    
    
    private func resendVerficationEmail() {
        
        FUserListener.shared.resendVerficationEmailWith(email: emailTextFieldOutlet.text!) { error in
            if error == nil {
                ProgressHUD.showSucceed("Verification email sent successfully")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    
    
    
    //MARK: Login user
    
    private func loginUser() {
        
        FUserListener.shared.loginUserWith(email: emailTextFieldOutlet.text!, password: passwordTextFieldOutlet.text!) { error, isEmailVerified in
            
            if error == nil {
                
                if isEmailVerified {
                    
                    self.goToApp()
                    
                    print("go to application")
                    
                    
                } else {
                    ProgressHUD.showFailed("Please check your email and verify your registration")
                    
                }
                
                
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
        
    }
    
        //MARK: Navigation
    
    private func goToApp() {
        
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
    
}


    //MARK: UI Text Delegate
extension LoginViewController: UITextFieldDelegate {

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        emailLabelOutlet.text = emailTextFieldOutlet.hasText ? "Email" : ""
        passwordLabelOutlet.text = passwordTextFieldOutlet.hasText ? "Password" : ""
        confirmPasswordLabelOutlet.text = confirmPasswordTextFieldOutlet.hasText ? "Confirm Password" : ""
    }

}
