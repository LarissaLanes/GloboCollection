import UIKit

class InfoViewController: UIViewController {

    var collectionData: Collection?

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
        label.textColor = .text
        label.textAlignment = .center
        return label
    }()

    private let objectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text
        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.red.cgColor
//        label.layer.cornerRadius = 5
//        let margin: CGFloat = 20
//        label.contentEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        

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
        label.textColor = .text // Mude a cor do texto para branco
        label.textAlignment = .center // Centralize o texto
        
        return label
    }()

    private let startQuizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Realizar quiz", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitleColor(.text, for: .normal) // Mude a cor do texto para branco
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 5
        let margin: CGFloat = 20
//        button.contentEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        return button
    }()

    private let showProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mostrar no Perfil", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.text, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        let margin: CGFloat = 20
//        button.contentEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage

        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton

        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(objectLabel)
        view.addSubview(dividerView)
        view.addSubview(descriptionLabel)
        view.addSubview(startQuizButton)
//        view.addSubview(showProfileButton)
        
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

            startQuizButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            startQuizButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    
        startQuizButton.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
        showProfileButton.addTarget(self, action: #selector(showProfileButtonTapped), for: .touchUpInside)
        
        if let collection = collectionData {
            
            let stickerID = UserDefaults.standard.integer(forKey: "stickerResgatado\(collection.id)")

            if stickerID == collection.id {
                print("id: \(stickerID)")
                imageView.image = UIImage(named: collection.imagemDesbloqueada)
                titleLabel.text = collection.nome
                descriptionLabel.text = collection.descricao
                startQuizButton.isHidden = true
                showProfileButton.isHidden = false
                
                if collection.raridade == true {
                    objectLabel.text = "RARA"
                    objectLabel.textColor = .red
                }else{
                    objectLabel.text = "NORMAL"
                    objectLabel.textColor = .white

                }

            } else {
                imageView.image = UIImage(named: collection.imagemBloqueada) 
                titleLabel.text = collection.nome
                descriptionLabel.text = "Opa! Parece que você ainda não tem essa figurinha. Faça o quiz abaixo para ter a chance de resgatá-la ;-)"
                startQuizButton.isHidden = false
                showProfileButton.isHidden = true
//                if collection.raridade == true {
//                    objectLabel.text = "RARA"
//                    objectLabel.textColor = .red
//                }else{
//                    objectLabel.text = "NORMAL"
//                    objectLabel.textColor = .white
//
//                }
            }
        }
    }
    
    @objc private func startQuizButtonTapped() {
        guard let collection = collectionData else {
            return
        }

        let novaViewController = WebViewController()
        novaViewController.collectionData = collection
        navigationController?.pushViewController(novaViewController, animated: true)
    }
    
    @objc private func showProfileButtonTapped() {
        print("mostrei a imagem no perfil")
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
