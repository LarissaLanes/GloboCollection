//
//  CollectionViewController.swift
//  collection
//
//  Created by Larissa Lanes on 30/08/23.
//

import UIKit

class CollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure a barra de navegação
        setupNavigationBar()
        
        // Defina o título da tela
        self.title = "Minha Coleção"
        
        // Defina a cor de fundo da vista
        self.view.backgroundColor = .grass
    }
    
    // Função para configurar a barra de navegação
    private func setupNavigationBar() {
        // Defina a cor de fundo da barra de navegação
        navigationController?.navigationBar.barTintColor = .black
        
        // Defina a cor do texto da barra de navegação
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // Crie um botão de "Editar" na barra de navegação
        let editButton = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }
    
    // Função chamada quando o botão de "Editar" é tocado
    @objc private func editButtonTapped() {
        // Implemente a lógica para a ação de edição aqui
        // Por exemplo, você pode abrir uma tela de edição de itens da coleção
        // Ou realizar qualquer outra ação que desejar ao tocar no botão "Editar"
    }
}

