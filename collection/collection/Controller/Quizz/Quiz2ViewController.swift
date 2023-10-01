import UIKit

class Quiz2ViewController: UIViewController {
    
    var collectionData: Collection?
    var quizId: Int = 2
    
    let userDefaults = UserDefaults.standard // Criar uma instância do UserDefaults


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
        "Qual bbb?",
        "Qual e teste 2 planeta do sistema solar?",
        "Quem escreveu 'Dom Quixote'?"
    ]

    private let correctAnswers = [
        "Brasília",
        "Júpiter",
        "Miguel de Cervantes"
    ]

    private var currentQuestionIndex = 0
    private var correctAnswersCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Oculta o botão de voltar na barra de navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
    }


    private func setupUI() {
        view.addSubview(questionLabel)
        view.addSubview(option1Button)
        view.addSubview(option2Button)
        view.addSubview(option3Button)

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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

    // ...
    private func updateUI() {
        if currentQuestionIndex < questions.count {
            questionLabel.text = questions[currentQuestionIndex]
            option1Button.setTitle("A) \(correctAnswers[currentQuestionIndex])", for: .normal)
            option2Button.setTitle("B) Júpiter", for: .normal)
            option3Button.setTitle("C) Miguel de Cervantes", for: .normal)
        } else {
            if correctAnswersCount >= 2 {
                // Redirecione para outra tela aqui
                let resultViewController = ResultViewController()
                resultViewController.collectionData = collectionData // Passe os dados da coleção

//                resultViewController.quizResult = "Quiz concluído com sucesso!"
                resultViewController.canRedeem = true // Mostrar botão de resgatar
                
//                if let stickerID = collectionData?.id {
//                    userDefaults.set(stickerID, forKey: "stickerResgatado")
//                }
                
                userDefaults.set(quizId, forKey: "quizCompleto")
//                userDefaults.set(collectionData?.id, forKey: "stickerResgatado2")
                
                navigationController?.pushViewController(resultViewController, animated: true)
            } else {
                // Redirecione para outra tela aqui
                let erroViewController = ErrorViewController()
                erroViewController.collectionData = collectionData // Passe os dados da coleção

//                resultViewController.quizResult = "Quiz não concluído. Tente novamente."
                erroViewController.canRedeem = false // Mostrar botão de reiniciar
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

//                resultViewController.quizResult = "Quiz concluído com sucessooooooo!"
                navigationController?.pushViewController(resultViewController, animated: true)
            } else {
                // Redirecione para outra tela aqui
                let erroViewController = ErrorViewController()
                erroViewController.collectionData = collectionData // Passe os dados da coleção

//                resultViewController.quizResult = "Quiz não concluído. Tente novamente."
                navigationController?.pushViewController(erroViewController, animated: true)
            }
        }
    }
}
