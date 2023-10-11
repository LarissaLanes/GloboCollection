import UIKit
import FirebaseFirestore

class Quiz1ViewController: UIViewController {
    
    var collectionData: Collection?
    var quizId: Int = 1
    let userDefaults = UserDefaults.standard // Criar uma instância do UserDefaults

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Quiz BBB21: Você sabe tudo sobre o Big dos Bigs?"
        return label
    }()

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let option1Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        return button
    }()

    private let option2Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        return button
    }()

    private let option3Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        return button
    }()

    private let questions = [
        "Quem foi o primeiro participante a entrar na casa do BBB21?",
        "E o primeiro brother eliminado do BBB21?",
        "Qual Brother do BBB23 tem uma irmã gêmea'?"
    ]

    private let correctAnswers = [
        "Gilberto (Gil do vigor)",
        "Kerline",
        "Key Alves"
    ]

    private var currentQuestionIndex = 0
    private var correctAnswersCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        updateUI()
    }

    private func setupNavigationBar() {
        // Configurar a imagem na barra de navegação
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo_globoplay") // Substitua "suaImagem" pelo nome da sua imagem
        imageView.image = image
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)

        // Configurar a cor de fundo da barra de navegação
        navigationController?.navigationBar.barTintColor = .purple
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Oculta o botão de voltar na barra de navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(option1Button)
        view.addSubview(option2Button)
        view.addSubview(option3Button)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            option1Button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            option1Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            option1Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            option2Button.topAnchor.constraint(equalTo: option1Button.bottomAnchor, constant: 16),
            option2Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            option2Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            option3Button.topAnchor.constraint(equalTo: option2Button.bottomAnchor, constant: 16),
            option3Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            option3Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    private func updateUI() {
        if currentQuestionIndex < questions.count {
            questionLabel.text = questions[currentQuestionIndex]
            option1Button.setTitle("A) \(correctAnswers[currentQuestionIndex])", for: .normal)
            option2Button.setTitle("B) Juliette", for: .normal)
            option3Button.setTitle("C) Bambam", for: .normal)
        } else {
            if correctAnswersCount >= 2 {
                // Redirecione para outra tela aqui
                let resultViewController = ResultViewController()
                resultViewController.collectionData = collectionData // Passe os dados da coleção
                userDefaults.set(quizId, forKey: "quizCompleto1")
                userDefaults.set(collectionData?.id, forKey: "stickerResgatado1")
                navigationController?.pushViewController(resultViewController, animated: true)
            } else {
                // Redirecione para outra tela aqui
                let erroViewController = ErrorViewController()
                erroViewController.collectionData = collectionData // Passe os dados da coleção
                navigationController?.pushViewController(erroViewController, animated: true)
            }
        }
    }

    @objc private func optionSelected(_ sender: UIButton) {
        let selectedAnswer = sender.currentTitle ?? ""

        if selectedAnswer == "A) \(correctAnswers[currentQuestionIndex])" {
            // Resposta correta
            correctAnswersCount += 1
            print("Resposta correta!")
        } else {
            // Resposta errada
            print("Resposta errada.")
        }

        // Avance para a próxima pergunta ou termine o quiz se todas as perguntas foram respondidas
        currentQuestionIndex += 1

        if currentQuestionIndex < questions.count {
            updateUI()
        } else {
            // Todas as perguntas foram respondidas
            if correctAnswersCount >= 2 {
                // Redirecione para outra tela aqui
                let resultViewController = ResultViewController()
                resultViewController.collectionData = collectionData // Passe os dados da coleção
                userDefaults.set(quizId, forKey: "quizCompleto1")
                userDefaults.set(collectionData?.id, forKey: "stickerResgatado1")
                navigationController?.pushViewController(resultViewController, animated: true)
            } else {
                // Redirecione para outra tela aqui
                let erroViewController = ErrorViewController()
                erroViewController.collectionData = collectionData // Passe os dados da coleção
                navigationController?.pushViewController(erroViewController, animated: true)
            }
        }
    }
}
