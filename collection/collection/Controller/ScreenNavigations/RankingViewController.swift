import UIKit
import FirebaseFirestore
import FirebaseAuth

struct User {
    var image: String
    var name: String
    var email: String
    var porcent: Int
    var uid: String
}

class RankingViewController: UIViewController {
    
    let tableView = UITableView()
    
    var usuarios = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllUsersFromFirestore()
    }
    
    
    func fetchAllUsersFromFirestore() {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        usersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar os dados dos usuários: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Nenhum documento encontrado.")
                return
            }
            
            for document in documents {
                if let data = document.data() as? [String: Any],
                   let email = data["email"] as? String,
                   let nickName = data["nick_name"] as? String,
                   let uid = data["uid"] as? String {
                    
                    let user = User(image: "ranking", name: nickName, email: email, porcent: 0, uid: uid)
                    self.usuarios.append(user)
                }
            }
            self.calculatePorcentagesFromUserScores()
        }
    }
    
    func calculatePorcentagesFromUserScores() {
        let db = Firestore.firestore()
        let userScoresRef = db.collection("user_scores")
        
        for (index, user) in self.usuarios.enumerated() {
            userScoresRef.document(user.uid).getDocument { (document, error) in
                if let error = error {
                    print("Erro ao buscar os dados de pontuação do usuário: \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists {
                    if let scoresData = document.data(),
                       let scores = scoresData["scores"] as? [[String: Any]] {
                        
                        var totalScore = 0
                        for scoreData in scores {
                            if let score = scoreData["score1"] as? Int {
                                totalScore += score
                            }
                        }
                        
                        let percentage = Double(totalScore) / Double(user.porcent) * 100
                        if percentage.isFinite {
                            self.usuarios[index].porcent = Int(percentage)
                        } else {
                            self.usuarios[index].porcent = 0
                        }
                            self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as! RankingTableViewCell
        
        cell.configure(with: usuarios[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
