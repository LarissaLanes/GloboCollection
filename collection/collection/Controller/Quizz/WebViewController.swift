//
//  WebViewController.swift
//  collection
//
//  Created by Larissa Lanes on 03/10/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView! // Declare a variável webView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem

        // Inicialize a webView
        webView = WKWebView()

        // Defina o tamanho da webView para preencher toda a tela
        webView.frame = view.bounds

        // Adicione a webView à view do seu UIViewController
        view.addSubview(webView)

        let url: URL? = URL(string: "https://gshow.globo.com/realities/bbb/bbb-23/noticia/quiz-bbb-23-voce-ja-sabe-tudo-sobre-os-participantes-teste-os-seus-conhecimentos.ghtml")

        if let value = url {
            // Carregue a URL na webView
            self.webView.load(URLRequest(url: value))
            
            self.webView.allowsBackForwardNavigationGestures = true
            
            // Mapeia as ações do usuário no site externo
            self.webView.navigationDelegate = self
        }
    }

    // MARK: - Navigation

}

