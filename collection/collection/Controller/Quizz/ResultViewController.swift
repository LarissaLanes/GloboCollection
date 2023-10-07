//
//  ResultViewController.swift
//  collection
//
//  Created by Larissa Lanes on 30/09/23.
//

import UIKit
import FirebaseFirestore

class ResultViewController: UIViewController {
    
    //    var quizResult: String?
    var canRedeem: Bool = false
    var collectionData: Collection?
    
    let userDefaults = UserDefaults.standard
    
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imagemBloqueada")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Sucesso!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stickerLabel: UILabel = {
        let label = UILabel()
        label.text = "sticker desbloqueado"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let redeemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resgatar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(redeemButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let galeryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver imagem na galeria", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(galeryButtonTapped), for: .touchUpInside)
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
        view.addSubview(stickerLabel)
        view.addSubview(redeemButton)
        view.addSubview(galeryButton)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultImageView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stickerLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 20),
            stickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stickerLabel.heightAnchor.constraint(equalToConstant: 200),
            
            redeemButton.topAnchor.constraint(equalTo: stickerLabel.bottomAnchor, constant: 30),
            redeemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redeemButton.widthAnchor.constraint(equalToConstant: 120),
            redeemButton.heightAnchor.constraint(equalToConstant: 40),
            
            galeryButton.topAnchor.constraint(equalTo: redeemButton.bottomAnchor, constant: 30),
            galeryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            galeryButton.widthAnchor.constraint(equalToConstant: 120),
            galeryButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configureButton() {
        
        if canRedeem == true{
            redeemButton.setTitle("Resgatar", for: .normal)
            redeemButton.addTarget(self, action: #selector(redeemButtonTapped), for: .touchUpInside)
            
            
        }
    }
    
    
    @objc private func redeemButtonTapped() {
        if let stickerID = collectionData?.id {
            print("ID da coleção encontrado: \(stickerID)")
            
            // Use a animação cross dissolve para suavizar a transição
            UIView.transition(with: resultImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.resultImageView.image = UIImage(named: self.collectionData?.imagemDesbloqueada ?? "imagemBloqueada")
            }, completion: nil)
            
            UIView.transition(with: stickerLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.stickerLabel.text = self.collectionData?.nome
            }, completion: nil)

            print("id guardado \(UserDefaults.standard.integer(forKey: "stickerResgatado\(stickerID)"))")
            print("id do quizz guaradado \(UserDefaults.standard.integer(forKey: "quizCompleto\(stickerID)"))")
            
            //pontuacao de cada sticker salvo no firebase
            
            
            if let userUID = UserDefaults.standard.string(forKey: "userUID") {
                // Salve a pontuação do sticker no Firestore associada ao UID do usuário
                let db = Firestore.firestore()
                
                db.collection("user_scores").document(userUID).setData([
                    "stickerID\(stickerID)": stickerID,
                    "stickerScore\(stickerID)": collectionData?.stickerScore ?? 0
                ]) { (error) in
                    if let error = error {
                        print("Erro ao salvar a pontuação do sticker: \(error.localizedDescription)")
                    } else {
                        print("Pontuação do sticker salva com sucesso.")
                    }
                }
            } else {
                print("UID do usuário não encontrado.")
            }

        } else {
            print("ID da coleção não encontrado.")
        }
    }
    
    @objc private func galeryButtonTapped() {
        let detailsTableController = TabBarController()
        navigationController?.pushViewController(detailsTableController, animated: true)
    }
}



