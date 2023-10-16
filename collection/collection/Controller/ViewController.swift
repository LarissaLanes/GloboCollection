//
//  ViewController.swift
//  collection
//
//  Created by Larissa Lanes on 30/08/23.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let userUID = UserDefaults.standard.string(forKey: "userUID"){
            print("UID do usuário:", userUID)
        }else{
            print("faca o login do usuario")
            redirectToLoginScreen()
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)

    }
    
    
    
    func redirectToLoginScreen(){
        let loginViewController = LoginViewController()
        navigationController?.setViewControllers([loginViewController], animated: false)
    }

    private func setupTabBarController(){
        
        //cor do icon
        tabBar.tintColor = .text
        //apenas pq vao ser Nvaigation controllers se nao forem precisa apenas instanciar diretamente no array de controllers
        let homeView = UINavigationController(rootViewController: CollectionViewController())
        let MyView = UINavigationController(rootViewController: CollectionViewController())
        let OptionView = UINavigationController(rootViewController: CollectionViewController())
        let DownloadsView = UINavigationController(rootViewController: CollectionViewController())
        let collectionView = UINavigationController(rootViewController: CollectionViewController())
        
        self.setViewControllers([homeView,OptionView,collectionView,MyView,DownloadsView], animated: false)
        self.tabBar.backgroundColor = .backgroundDetails
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else {return}
        
        items[0].title = "Início"
        if let homeImage = UIImage(named: "homewhite"){
            items[0].image = homeImage
        }
        
        items[1].title = "Agora"
        if let nowImage = UIImage(named: "transmissaowhite"){
            items[1].image = nowImage
        }
        
        items[2].title = "Collection"
        if let collectionImage = UIImage(named: "collectionwhite"){
            items[2].image = collectionImage
        }
        
        items[3].title = "Meu Globoplay"
        if let globoplayImage = UIImage(named: "meugloboplaywhite"){
            items[3].image = globoplayImage
        }
        
        items[4].title = "Dowloads"
        if let dowloadImage = UIImage(named: "downloadswhite"){
            items[4].image = dowloadImage
        }
    }
}




