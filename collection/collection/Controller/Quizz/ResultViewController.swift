//
//  ResultViewController.swift
//  collection
//
//  Created by Larissa Lanes on 30/09/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ResultViewController: UIViewController {
    
    var canRedeem: Bool = false
    var collectionData: Collection?
    
    private let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "urlBloq_1")
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
        label.textColor = .text
        return label
    }()
    
    private let stickerLabel: UILabel = {
        let label = UILabel()
        label.text = "sticker desbloqueado"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .text
        return label
    }()
    
    private let redeemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resgatar", for: .normal)
        button.layer.borderWidth = 1
        button.setTitleColor(.text, for: .normal) // Mude a cor do texto para branco
        button.layer.borderColor = UIColor.red.cgColor
        let margin: CGFloat = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .none
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(redeemButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let galeryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver na galeria", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(galeryButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.setTitleColor(.text, for: .normal) // Mude a cor do texto para branco
        button.layer.borderColor = UIColor.red.cgColor
        let margin: CGFloat = 20
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
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultImageView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stickerLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 10),
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
    
    @objc private func redeemButtonTapped() {
           if let stickerID = collectionData?.id {
               print("ID da coleção encontrado: \(stickerID)")

               let userDefaults = UserDefaults.standard
               userDefaults.set(collectionData?.id, forKey: "stickerResgatado\(String(describing: stickerID))")
               
               UIView.transition(with: resultImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                   self.resultImageView.image = UIImage(named: self.collectionData?.imagemDesbloqueada ?? "urlBloq_\(stickerID)")
               }, completion: nil)
               
               UIView.transition(with: stickerLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                   self.stickerLabel.text = self.collectionData?.nome
               }, completion: nil)
               
               // salvando no firebase
               if let userUID = UserDefaults.standard.string(forKey: "userUID") {
                   let db = Firestore.firestore()
                   let userScoresRef = db.collection("user_scores").document(userUID)
                   
                   // Crie um dicionário com a pontuação do sticker
                   let stickerScore: [String: Any] = [
                       "stickerID\(stickerID)": stickerID,
                       "score\(stickerID)": collectionData?.stickerScore ?? 0,
                       "uid": userUID
                   ]
                   
                   userScoresRef.getDocument { (document, error) in
                       if let document = document, document.exists {
                           userScoresRef.updateData([
                               "scores": FieldValue.arrayUnion([stickerScore])
                           ]) { (error) in
                               if let error = error {
                                   print("Erro ao salvar a pontuação do sticker: \(error.localizedDescription)")
                               } else {
                                   print("Pontuação do sticker salva com sucesso.")
                               }
                           }
                       } else {
                           userScoresRef.setData([
                               "scores": [stickerScore]
                           ]) { (error) in
                               if let error = error {
                                   print("Erro ao criar o documento do usuário: \(error.localizedDescription)")
                               } else {
                                   print("Documento do usuário criado com sucesso.")
                               }
                           }
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
