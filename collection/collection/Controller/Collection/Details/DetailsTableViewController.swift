import UIKit

class DetailsTableViewController: UIViewController {
    
    var collections: [Collection]?
    var cellID: String?

    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "fundoBBB")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "BBBLOGO") 
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage
        self.tableView.backgroundColor = .backgroundPage
        
        let backButton = UIBarButtonItem(title: "Álbum BBB", style: .plain, target: self, action: #selector(backButtonTapped))
           self.navigationItem.leftBarButtonItem = backButton

        //botoes de modal na barra de navegacao
        let buttonRanking = CustomBarButton(image: UIImage(named: "ranking")!, target: self, action: #selector(buttonRankingTapped))
        let buttonReward = CustomBarButton(image: UIImage(named: "recompensas")!, target: self, action: #selector(buttonRewardTapped))
        let buttonSearch = CustomBarButton(image: UIImage(named: "collectionwhite")!, target: self, action: #selector(buttonSearchTapped))
        let buttonProfile = CustomBarButton(image: UIImage(named: "pesquisar")!, target: self, action: #selector(buttonProfileTapped))
        
        navigationItem.rightBarButtonItems = [buttonProfile,buttonSearch,buttonReward,buttonRanking]
        //

        view.addSubview(backgroundImage)
        view.addSubview(secondImage)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 200),

            secondImage.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 20),
            secondImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondImage.heightAnchor.constraint(equalToConstant: 80),

            tableView.topAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(UINib(nibName: "GalerysTableViewCell", bundle: nil), forCellReuseIdentifier: "GalerysTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonRankingTapped() {
        let modalViewController = RankingViewController()
        self.present(modalViewController, animated: true, completion: nil)
    }
    
    @objc func buttonRewardTapped() {
        let modalViewController = RewardViewController()
        self.present(modalViewController, animated: true, completion: nil)
    }
    
    @objc func buttonSearchTapped() {
        print("Dados do UserDefaults excluídos!")

        let userDefaults = UserDefaults.standard

        let keysToDelete = ["stickerResgatado1", "stickerResgatado2", "stickerResgatado3", "stickerResgatado4", "stickerResgatado5", "stickerResgatado6", "stickerResgatado7", "stickerResgatado8", "stickerResgatado9", "stickerResgatado10", "stickerResgatado11", "stickerResgatado12", "stickerResgatado13", "stickerResgatado14", "stickerResgatado15", "stickerResgatado16", "stickerResgatado17", "stickerResgatado18", "stickerResgatado19", "stickerResgatado20"]

        for key in keysToDelete {
            userDefaults.removeObject(forKey: key)
        }
        
        userDefaults.synchronize()
    }
    
    @objc func buttonProfileTapped() {
        print("Botão de imagem tocado!")
    }
}

extension DetailsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalerysTableViewCell", for: indexPath) as! GalerysTableViewCell

        if let collections = collections {
            cell.configure(with: collections)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 9000
    }
}
