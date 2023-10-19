//
//  WebViewController.swift
//  collection
//
//  Created by Larissa Lanes on 03/10/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var collectionData: Collection?
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(voltarButtonPressionado))
        navigationItem.leftBarButtonItem = backButton

        webView = WKWebView()
        webView.frame = view.bounds
        view.addSubview(webView)
        
        var urlString: String

        switch collectionData?.id {
        case 1:
            urlString = "https://gshow.globo.com/realities/bbb/bbb-23/noticia/quiz-bbb-23-voce-ja-sabe-tudo-sobre-os-participantes-teste-os-seus-conhecimentos.ghtml"
        case 2:
            urlString = "https://pt.quizur.com/quiz/qual-classico-do-dia-do-mcdonalds-combina-com-a-sua-personalidade-4LSQ"

        default:
            urlString = "https://gshow.globo.com/realities/bbb/bbb-23/noticia/quiz-bbb-23-voce-lembra-quem-disse-isso.ghtml"
        }

        if let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
            self.webView.navigationDelegate = self
        }
    }
    
    @objc func voltarButtonPressionado() {
        let resultViewController = ResultViewController()
        resultViewController.collectionData = collectionData
        userDefaults.set(collectionData?.id, forKey: "stickerResgatado\(String(describing: collectionData?.id))")
        navigationController?.pushViewController(resultViewController, animated: true)
        print("botao de voltar clicado")
    }
}


