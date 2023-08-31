//
//  ViewController.swift
//  collection
//
//  Created by Larissa Lanes on 30/08/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarController()
    }
    
    private func setupTabBarController(){
        
        //apenas pq vao ser Nvaigation controllers se nao forem precisa apenas instanciar diretamente no array de controllers
        let homeView = UINavigationController(rootViewController: HomeViewController())
        let MyView = UINavigationController(rootViewController: MyViewController())
        let OptionView = UINavigationController(rootViewController: OptionViewController())
        let DownloadsView = UINavigationController(rootViewController: DownloadsViewController())
        let collectionView = UINavigationController(rootViewController: CollectionViewController())
        
        self.setViewControllers([homeView,MyView,OptionView,DownloadsView,collectionView], animated: false)
        self.tabBar.backgroundColor = .black
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else {return}
        
        items[0].title = "Início"
        items[0].image = UIImage(systemName: "star")
        
        items[1].title = "Meu Globoplay"
        items[1].image = UIImage(systemName: "star")
        
        items[2].title = "Catálogo"
        items[2].image = UIImage(systemName: "star")
        
        items[3].title = "Downloads"
        items[3].image = UIImage(systemName: "star")
        
        items[4].title = "Collection"
        items[4].image = UIImage(systemName: "star")
    }
}




