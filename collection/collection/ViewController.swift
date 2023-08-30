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
        let tela01 = UINavigationController(rootViewController: Tela01())
        let tela02 = UINavigationController(rootViewController: Tela02())
        let tela03 = UINavigationController(rootViewController: Tela03())
        let tela04 = UINavigationController(rootViewController: Tela04())
        
        self.setViewControllers([tela01,tela02,tela03,tela04], animated: false)
    }
}




class Tela01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.title = "home"
        
    }
}

class Tela02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.title = "2"
        
    }
}

class Tela03: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        self.title = "3"
        
    }
}

class Tela04: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        self.title = "home"
        
    }
}

