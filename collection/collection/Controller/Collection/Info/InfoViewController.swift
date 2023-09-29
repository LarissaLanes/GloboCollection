//
//  InfoViewController.swift
//  collection
//
//  Created by Larissa Lanes on 29/09/23.
//

import UIKit

class InfoViewController: UIViewController {
    
    var collectionData: Collection?
    
    // Adicione as visualizações para a imagem, o título, o objeto da imagem, o divisor e o texto
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let objectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundPage
        
        // Adicione as visualizações à hierarquia de visualização
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(objectLabel)
        view.addSubview(dividerView)
        view.addSubview(descriptionLabel)
        
        // Configure as restrições de layout
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            objectLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            objectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            objectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dividerView.topAnchor.constraint(equalTo: objectLabel.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
        ])
        
        // Verifique se há dados da coleção e atualize as visualizações com os dados
        if let collection = collectionData {
            // Configure a imagem, o título, o objeto e o texto com os dados da coleção
            imageView.image = UIImage(named: collection.imagem) // Substitua pela imagem real
            titleLabel.text = collection.nome
            objectLabel.text = collection.objetos
            descriptionLabel.text = collection.descricao
            
            // Faça qualquer outra coisa que você deseja fazer com os dados da coleção
        }
    }
    
    // Resto da sua implementação da InfoCollectionViewController
}
