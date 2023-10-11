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
        label.textColor = .text // Mude a cor do texto para branco
        label.textAlignment = .center // Centralize o texto
        return label
    }()

    private let objectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text // Mude a cor do texto para branco
        label.textAlignment = .center // Centralize o texto
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

    // Adicione um botão para iniciar o quiz
    private let startQuizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Realizar quiz", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitleColor(.text, for: .normal) // Mude a cor do texto para branco
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 5
        let margin: CGFloat = 20
        button.contentEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
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
        let margin: CGFloat = 20 // Ajuste o valor conforme necessário
        button.contentEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage

        // Adicione um botão de voltar
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton

        // Adicione as visualizações à hierarquia de visualização
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(objectLabel)
        view.addSubview(dividerView)
        view.addSubview(descriptionLabel)
        view.addSubview(startQuizButton) // Adicione o botão
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
            
//            showProfileButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//            showProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    
         
        
    
        startQuizButton.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
        showProfileButton.addTarget(self, action: #selector(showProfileButtonTapped), for: .touchUpInside)
        
        // Verifique se há dados da coleção e atualize as visualizações com os dados
        if let collection = collectionData {
            
            let stickerID = UserDefaults.standard.integer(forKey: "stickerResgatado\(collection.id)")
            let completedQuizID = UserDefaults.standard.integer(forKey: "quizCompleto\(collection.id)")


            if stickerID == collection.id {
                print("id: \(stickerID)")
                imageView.image = UIImage(named: collection.imagemDesbloqueada) // Substitua pela imagem real
                titleLabel.text = collection.nome
                objectLabel.text = collection.objetos
                descriptionLabel.text = collection.descricao

            } else {
                imageView.image = UIImage(named: collection.imagemBloqueada) // Substitua pela imagem real
                titleLabel.text = "Figurinha Bloqueada\(collection.id)"
                objectLabel.text = ""
                descriptionLabel.text = "Opa! Parece que você ainda não tem essa figurinha. Faça o quiz abaixo para ter a chance de resgatá-la ;-)"

            }
           
            
            //faz a troca dos botoes se o quiz ja estviver completo
            if completedQuizID == collection.id {
                startQuizButton.isHidden = true
                showProfileButton.isHidden = false
            }else{
                startQuizButton.isHidden = false
                showProfileButton.isHidden = true


            }
            
        }
    }
    
    // Método de ação para o botão de iniciar o quiz
    @objc private func startQuizButtonTapped() {
//        let novaViewController = WebViewController()
//        navigationController?.pushViewController(novaViewController, animated: true)

        
        
        //quizz externo
                guard let collection = collectionData else {
            return
        }

        // Com base no ID da coleção, redirecione para o quiz apropriado
        switch collection.id {
        case 1:
            let quiz1ViewController = Quiz1ViewController()
            quiz1ViewController.collectionData = collection

            navigationController?.pushViewController(quiz1ViewController, animated: true)
        case 2:
            let quiz2ViewController = Quiz2ViewController()
            quiz2ViewController.collectionData = collection

            navigationController?.pushViewController(quiz2ViewController, animated: true)
        // Adicione mais casos para outros IDs de coleção e quizzes, conforme necessário
        default:
            break
        }
    }
    
    // Método de ação para o botão "Mostrar no Perfil"
      @objc private func showProfileButtonTapped() {
          // Implemente a lógica para mostrar no perfil
          print("mostrei a imagem no perfil")
      }
    
    
    @objc private func backButtonTapped() {
        // Aqui você pode definir a ação a ser executada quando o botão "Voltar" for pressionado
        // Por exemplo, voltar para a tela anterior
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
}
