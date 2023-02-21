//
//  ViewController.swift
//  TodoApp
//
//  Created by gurzu on 01/12/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginText: UILabel!
    @IBOutlet weak var gurzuLogo: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func viewComponents() {
        // image for logo
        gurzuLogo.image = UIImage(named: "gurzu-one-line-logo")
        // login text
        loginText.text = "LogIn"
        loginText.textColor = UIColor(red: 5/255, green: 150/255, blue: 250/255, alpha: 1)
        loginText.textAlignment = .center
        // userName Text Field
        userNameTextField.placeholder = "Enter Username"
//        userNameTextField.delegate = self
        // password Text Field
        passwordTextField.placeholder = "Enter Password"
        // login button
        logInButton.setTitle("Login", for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        // Forgot Password Button
        forgotPasswordButton.setTitle("Forgot Password ?", for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        // SignUp Button
        signUpButton.setTitle("I Don't have an Account.", for: .normal)
    }
    
    @objc private func logInButtonPressed() {
        if let viewContrtoller = storyboard?.instantiateViewController(withIdentifier: "ProfilePageViewController") as?
            ProfilePageViewController {
            navigationController?.pushViewController(viewContrtoller, animated: true)
        }
    }
    
    @objc private func forgotPasswordButtonPressed() {
        if let userName = userNameTextField.text {
            let alert = UIAlertController(
                title: "Hello \(userName)",
                message: nil,
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(
                title: "Okay",
                style: .default,
                handler: nil
                )
            )
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: .destructive
                )
            )
            present(alert, animated: true)
        }
    }
}
