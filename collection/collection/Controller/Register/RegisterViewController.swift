//
//  RegisterViewController.swift
//  collection
//
//  Created by Larissa Lanes on 13/09/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome de usuário"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
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
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cadastrar", for: .normal)
        button.backgroundColor = .systemGreen
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
    
    //metodos
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateFields() -> String? {
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "preste atencao aos espacos"
        }
        return nil
    }
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 40),
        ])
            signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    // MARK: - Actions
    @objc private func signupButtonTapped() {
            
        let error = validateFields()
            
        if error != nil{
                
            print("falha ao cadastrar: \(error)")
            self.alert(title: "atencao", message: "falha ao cadastrardss")
        
        }else{
            
            let userName = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, err) in
                
                if err != nil {
                    
                    print("erro ao criar o usuario\(err)")
                    
                }else{
                    
                    print("usuario criado com sucesso!")

                    if let user = result?.user{
                        let uid = user.uid
                        UserDefaults.standard.set(uid, forKey: "userUID")
                        print(UserDefaults.standard.set(uid, forKey: "userUID")
                    )}
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["nick_name" : userName, "email" : email, "uid" : result!.user.uid]) { (error) in
                        
                        if error != nil {
                            print("deu error, usuario nao cadastrado")
                        }
                    }
                    self.transitionToTabBar()
                }
            }
        }
    }
    
    func transitionToTabBar() {
        let tabBarControlle = TabBarController()
        
        self.navigationController?.setViewControllers([tabBarControlle], animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}


