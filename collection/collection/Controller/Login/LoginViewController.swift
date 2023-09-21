//
//  LoginViewController.swift
//  collection
//
//  Created by Larissa Lanes on 13/09/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let userImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Globoplay_logo")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("ir para o cadastro", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - View Lifecycle
    var auth:Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        
        setupUI()
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(userImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        
        // Constraints
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userImageView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            
            emailTextField.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Target action for login button
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {

        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: pass) {(result, error) in
            
            if error != nil {
                print("falha ao logar: \(error)")
                self.alert(title: "atenção", message: "\(error)")
                
            }else {
                
                self.transitionToTabBar()
                //userdefaults
                if let user = result?.user{
                    let uid = user.uid
                    UserDefaults.standard.set(uid, forKey: "userUID")
                    print(UserDefaults.standard.set(uid, forKey: "userUID")
)
                }
                print("login feito com sucesso")
                self.alert(title: "parabens", message: "login feito com sucesso!")

                
            }
        }
//        self.auth?.signIn(withEmail: email, password: pass, completion: { (user, error) in
//
//            if error != nil{
//                self.alert(title: "atencao", message: "dados incorretos")
//                print("Usuário não encontrado \(error)")
//
//            }else{
//
//                if user == nil{
//                    self.alert(title: "atencao", message: "tivemos um problema inesperado")
//                    print("tivemos um problema inesperado ou usuario nao existente")
//
//                }else{
//                    self.alert(title: "parabens", message: "login feito com sucesso!")
//                    print("login feito com sucesso")
//
////                    self.transitionToTabBar()
//                }
//
//            }
//
//        })
    }
    
    @objc private func registerButtonTapped() {
        
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func transitionToTabBar() {
        let tabBarControlle = TabBarController()
        
        self.navigationController?.setViewControllers([tabBarControlle], animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//    func transitionToTabBar() {
//        let tabBarControlle = TabBarController()
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.window?.rootViewController = tabBarControlle
//        }
//    }


}



