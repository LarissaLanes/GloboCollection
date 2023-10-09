import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Excluir Conta", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(deleteAccountButton)
        
        NSLayoutConstraint.activate([
            deleteAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteAccountButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            deleteAccountButton.widthAnchor.constraint(equalToConstant: 200),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func deleteAccountButtonTapped() {
        let alertController = UIAlertController(title: "Excluir Conta", message: "Tem certeza de que deseja excluir sua conta?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Sim", style: .destructive) { (_) in
            self.deleteAccount()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func deleteAccount() {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            let db = Firestore.firestore()
            let auth = Auth.auth()
            
            if let currentUser = auth.currentUser {
                // O usuário está autenticado, então podemos prosseguir com a exclusão da conta
                
                // Exclua o documento do usuário no Firestore
                db.collection("users").document(userUID).delete { (error) in
                    if let error = error {
                        print("Erro ao excluir documento do usuário no Firestore: \(error.localizedDescription)")
                    } else {
                        print("Documento do usuário excluído com sucesso no Firestore.")
                        UserDefaults.standard.removeObject(forKey: "userUID")

                        
                        // Exclua a conta do Firebase
                        currentUser.delete { (error) in
                            if let error = error {
                                print("Erro ao excluir a conta do usuário no Firebase: \(error.localizedDescription)")
                            } else {
                                print("Conta do usuário excluída com sucesso no Firebase.")
                                
                                // Limpe o UID do usuário no armazenamento local
                                UserDefaults.standard.removeObject(forKey: "userUID")
                                
                                // Redirecione o usuário para a tela de login
                                self.transitionToLogin()
                            }
                        }
                    }
                }
            } else {
                print("O usuário não está autenticado. Solicite que faça login novamente.")
                // Exibir uma mensagem de erro ou redirecionar o usuário para a tela de login
            }
        } else {
            print("UID do usuário não encontrado no armazenamento local.")
        }
    }
    
    func transitionToLogin() {
        let loginViewController = LoginViewController()
        
        // Redireciona o usuário para a tela de login (ou apropriada)
        // Certifique-se de que o controlador de navegação esteja configurado para a tela de login
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([loginViewController], animated: true)
            navigationController.setNavigationBarHidden(true, animated: false)
        } else {
            // Caso o controlador de navegação não esteja configurado, apresente a tela de login de alguma outra maneira.
            // Por exemplo, você pode apresentar o controlador de login como uma janela modal.
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}
