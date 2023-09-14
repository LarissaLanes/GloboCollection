//
//  SceneDelegate.swift
//  collection
//
//  Created by Larissa Lanes on 30/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let safeWindow = UIWindow(windowScene: windowScene)
        safeWindow.frame = UIScreen.main.bounds
        
        let firstScreen = LoginViewController()
        let navViewController = UINavigationController(rootViewController: firstScreen)
        safeWindow.rootViewController = navViewController
        safeWindow.makeKeyAndVisible()
        window = safeWindow
    }
}

