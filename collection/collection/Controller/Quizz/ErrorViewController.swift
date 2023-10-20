//
//  ErrorViewController.swift
//  collection
//
//  Created by Larissa Lanes on 01/10/23.
//

import UIKit

class ErrorViewController: UIViewController {

    var canRedeem: Bool = false
    var collectionData: Collection?
    
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imagemBloqueada")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Infelizmente voce nao concluiu o quizz!!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let redeemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reiniciar o quizz", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPage
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupUI() {
        view.addSubview(resultLabel)
        view.addSubview(resultImageView)
        view.addSubview(redeemButton)

        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultImageView.heightAnchor.constraint(equalToConstant: 200),
            
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            redeemButton.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 30),
            redeemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redeemButton.widthAnchor.constraint(equalToConstant: 120),
            redeemButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configureButton() {
           if canRedeem == false{
               redeemButton.setTitle("Reiniciar o quizz", for: .normal)
               redeemButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
           }
       }
    
    
    @objc private func restartButtonTapped() {
        print("botao de recomecar o quizz pressionado")
        
        guard let collection = collectionData else {
        return
        }

        let novaViewController = WebViewController()
        novaViewController.collectionData = collection
        navigationController?.pushViewController(novaViewController, animated: true)
    }
}


