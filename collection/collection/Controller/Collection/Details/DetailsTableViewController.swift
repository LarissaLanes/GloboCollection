import UIKit

class DetailsTableViewController: UIViewController {
    
    var collections: [Collection]?
    var cellID: String?

    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "fundoBBB") // Substitua pelo nome da imagem da parede com grade
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let secondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "BBBLOGO") // Substitua pelo nome da segunda imagem
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

        view.addSubview(backgroundImage)
        view.addSubview(secondImage)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 200), // Ajuste a altura conforme necessário

            secondImage.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 20),
            secondImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondImage.heightAnchor.constraint(equalToConstant: 80), // Ajuste a altura conforme necessário

            tableView.topAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(UINib(nibName: "GalerysTableViewCell", bundle: nil), forCellReuseIdentifier: "GalerysTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
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
        return 900
    }
}
