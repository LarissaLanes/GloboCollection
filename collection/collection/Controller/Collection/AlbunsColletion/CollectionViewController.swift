import UIKit


struct Model {
    let id: Int
    let text: String
    let imageName: String
    let imageDetails: String
    let figurinhas: [Collection]
    
    init(id: Int, text: String, imageName: String, imageDetails: String, figurinhas: [Collection]) {
        self.id = id
        self.text = text
        self.imageName = imageName
        self.imageDetails = imageDetails
        self.figurinhas = figurinhas
    }
}

struct Collection {
    let id: Int
    let nome: String
    let imagem: String
    let objetos: String
    let descricao: String
    
    init(id: Int, nome: String, imagem: String, objetos: String, descricao: String) {
        self.id = id
        self.nome = nome
        self.imagem = imagem
        self.objetos = objetos
        self.descricao = descricao
    }
}

struct ModelRecents {
    let image: String
    let title: String
    let legend: String
    
    init(image: String, title: String, legend: String) {
        self.image = image
        self.title = title
        self.legend = legend
    }
}

class CollectionViewController: UIViewController {
    
    //models
        var models = [Model]()
        var recents = [ModelRecents]()
        var selectedRow = 0
    
        var data = [[RecentTableViewCell()],[CollectionTableViewCell()]]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage


        // Crie uma instância da tela de componentes
        let componentScreen = ComponentScreen()
        componentScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(componentScreen)

        // Configurar a imagem e o texto na tela de componentes
        componentScreen.imageView.image = UIImage(named: "globoCollectionLogo")
        componentScreen.label.text = "Seu álbum de melhores momentos."
        componentScreen.label.textColor = .white // Defina a cor do texto como branco

        // Configure as restrições de layout para a tela de componentes com espaço no topo
        NSLayoutConstraint.activate([
            componentScreen.imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            componentScreen.imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            componentScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            componentScreen.label.topAnchor.constraint(equalTo: componentScreen.imageView.bottomAnchor, constant: 20),
            componentScreen.label.leadingAnchor.constraint(equalTo: componentScreen.imageView.leadingAnchor),
            componentScreen.label.trailingAnchor.constraint(equalTo: componentScreen.imageView.trailingAnchor),
        ])
        
        // Crie uma UITableView programaticamente
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroundPage
        view.addSubview(tableView)
        
        // Configure as restrições de layout para a UITableView abaixo do texto
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: componentScreen.label.bottomAnchor, constant: 20), // Ajuste o valor de "constant" conforme necessário para definir o espaço entre o texto e a UITableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Registre as células da UITableView e defina o dataSource e delegate conforme necessário
        tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableViewCell")
               tableView.dataSource = self
               tableView.delegate = self
               
               //dados do array de figurinhas
               //figurinhas
        let collection1 = Collection(id: 1, nome: "Cacto Lider", imagem: "bbb6", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        let collection2 = Collection(id: 2, nome: "Rob BBB Laranja", imagem: "bbb6", objetos: "RobBBB", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        let collection3 = Collection(id: 3, nome: "Cacto Lider", imagem: "bbb6", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        let collection4 = Collection(id: 4, nome: "Rob BBB Laranja", imagem: "bbb6", objetos: "RobBBB", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        let collection5 = Collection(id: 5, nome: "Cacto Lider", imagem: "bbb6", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        let collection6 = Collection(id: 5, nome: "Cacto Lider", imagem: "bbb6", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.")
        

                       
//                       model album
                       models.append(Model(id: 1, text: "BBB", imageName: "image_1", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5,collection6,collection1, collection6]))
                       models.append(Model(id: 2, text: "Tunel do amor", imageName: "image_2", imageDetails: "bbb1", figurinhas: [collection2,collection1,collection3,collection4,collection5]))
                       models.append(Model(id: 3, text: "No limite", imageName: "image_3", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
                       models.append(Model(id: 4, text: "The voice", imageName: "image_4", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
                       models.append(Model(id: 5, text: "The masked singer", imageName: "image_5", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
       
                       //recents
                       recents.append(ModelRecents(image: "bbb3", title: "Cacto", legend: "big brotherbrasil"))
                       recents.append(ModelRecents(image: "bbb3", title: "Cacto 4", legend: "big brother brasil"))
                       recents.append(ModelRecents(image: "bbb3", title: "Cacto 4", legend: "big brother brasil"))
                       recents.append(ModelRecents(image: "bbb3", title: "Cacto 3", legend: "big brother brasil"))
                        recents.append(ModelRecents(image: "bbb3", title: "Cacto lider", legend: "big brother brasil"))
                        recents.append(ModelRecents(image: "bbb3", title: "Cacto lider", legend: "big brother brasil"))


    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data[section].count
        }else {
            return data[section].count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
            cell.configure(with: recents)

            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }



}

