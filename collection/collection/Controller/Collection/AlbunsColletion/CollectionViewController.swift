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
    let imagemDesbloqueada: String
    let imagemBloqueada: String
    let objetos: String
    let descricao: String
    let album: String
    let stickerScore: Int
    
    init(id: Int, nome: String, imagemDesbloqueada: String, imagemBloqueada: String, objetos: String, descricao: String, album: String, stickerScore: Int) {
        self.id = id
        self.nome = nome
        self.imagemDesbloqueada = imagemDesbloqueada
        self.imagemBloqueada = imagemBloqueada
        self.objetos = objetos
        self.descricao = descricao
        self.album  = album
        self.stickerScore = stickerScore
    }
}

////excluir no futuro(usar o array de sticker do usuario no firebase)
struct ModelRecents {
    let id: Int
    let nome: String
    let imagemDesbloqueada: String
    let imagemBloqueada: String
    let objetos: String
    let descricao: String
    let album: String
    let stickerScore: Int // Adicione esta propriedade

    init(id: Int, nome: String, imagemDesbloqueada: String, imagemBloqueada: String, objetos: String, descricao: String, album: String, stickerScore: Int) {
        self.id = id
        self.nome = nome
        self.imagemDesbloqueada = imagemDesbloqueada
        self.imagemBloqueada = imagemBloqueada
        self.objetos = objetos
        self.descricao = descricao
        self.album = album
        self.stickerScore = stickerScore
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
        let collection1 = Collection(id: 1, nome: "Boninho", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        let collection2 = Collection(id: 2, nome: "Rob BBB Laranja", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "RobBBB", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        let collection3 = Collection(id: 3, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        let collection4 = Collection(id: 4, nome: "Rob BBB Laranja", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "RobBBB", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        let collection5 = Collection(id: 5, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        let collection6 = Collection(id: 6, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 10)
        

                       
//                       model album
                       models.append(Model(id: 1, text: "BBB", imageName: "image_1", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5,collection6]))
                       models.append(Model(id: 2, text: "Tunel do amor", imageName: "image_2", imageDetails: "bbb1", figurinhas: [collection2,collection1,collection3,collection4,collection5]))
                       models.append(Model(id: 3, text: "No limite", imageName: "image_3", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
                       models.append(Model(id: 4, text: "The voice", imageName: "image_4", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
                       models.append(Model(id: 5, text: "The masked singer", imageName: "image_5", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5]))
       
                       //recents
        recents.append(ModelRecents(id: 1, nome: "Boninho", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 2, nome: "Rob BBB Laranja", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 3, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 4, nome: "Rob BBB Laranja", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 5, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 6, nome: "Cacto Lider", imagemDesbloqueada: "stickerBoninho", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))


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

