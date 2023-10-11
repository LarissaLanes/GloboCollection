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
        

        
        //botoes de modal na barra de navegacao
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .backgroundPage // Define o background como preto

        // Defina a altura desejada para a barra de navegação
        let barHeight: CGFloat = 500.0
              let barFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: barHeight)
              navigationBar.frame = barFrame

                // Crie um item de navegação com um título à esquerda
        let navigationItem = UINavigationItem()
        let leftTitleItem = UIBarButtonItem(title: "Collection", style: .plain, target: nil, action: nil)

        navigationItem.leftBarButtonItem = leftTitleItem
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false


        
        let buttonSearch = CustomBarButton(image: UIImage(named: "pesquisar")!, target: self, action: #selector(buttonSearchTapped))
        let buttonProfile = CustomBarButton(image: UIImage(named: "ranking")!, target: self, action: #selector(buttonProfileTapped))
        
        navigationItem.rightBarButtonItems = [buttonProfile,buttonSearch]
        //

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
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            componentScreen.imageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 50),
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
            tableView.topAnchor.constraint(equalTo: componentScreen.label.bottomAnchor, constant: 40), // Ajuste o valor de "constant" conforme necessário para definir o espaço entre o texto e a UITableView
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
        let collection1 = Collection(id: 1, nome: "RoBBB Mau", imagemDesbloqueada: "url_1", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "RoBBB Mau, a personificação do Castigo do Monstro. Nele, a produção determina ações desconfortáveis ao longo de todo um final de semana.", album: "BBB", stickerScore: 10)
        let collection2 = Collection(id: 2, nome: "McDonald’s", imagemDesbloqueada: "url_2", imagemBloqueada: "imagemBloqueada", objetos: "RobBBB", descricao: "Patrocinador oficial do BBB, transformando lanches em estrelas do reality show mais saboroso! Quem criará a próxima Méquizice surpreendente? 🍔✨", album: "BBB", stickerScore: 10)
        let collection3 = Collection(id: 3, nome: "Karol Conká", imagemDesbloqueada: "url_3", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection4 = Collection(id: 4, nome: "Big Fone", imagemDesbloqueada: "url_4", imagemBloqueada: "imagemBloqueada", objetos: "RobBBB", descricao: "Elemento icônico do Big Brother Brasil que promete trazer uma surpresa para o jogo. Quem o atender pode ser imunizado, eliminado ou encaminhado ao paredão… tudo pode acontecer!", album: "BBB", stickerScore: 10)
        let collection5 = Collection(id: 5, nome: "Pedro Bial", imagemDesbloqueada: "url_5", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection6 = Collection(id: 6, nome: "Tiago Leifert", imagemDesbloqueada: "url_6", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection7 = Collection(id: 7, nome: "Viih Tube", imagemDesbloqueada: "url_7", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection8 = Collection(id: 8, nome: "RoBBB Verde", imagemDesbloqueada: "url_8", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection9 = Collection(id: 9, nome: "RoBBB Rosa", imagemDesbloqueada: "url_9", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection10 = Collection(id: 10, nome: "RoBBB Azul", imagemDesbloqueada: "url_10", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection11 = Collection(id: 11, nome: "Juliette", imagemDesbloqueada: "url_12", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Juliette, a rainha do carisma, é uma advogada que virou fenômeno após vencer o BBB 21. Com sua simpatia, conquistou o país e virou meme oficial do Brasil!", album: "BBB", stickerScore: 20)
        let collection12 = Collection(id: 12, nome: "RoBBB Anjo", imagemDesbloqueada: "url_13", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection13 = Collection(id: 13, nome: "Samsung", imagemDesbloqueada: "url_14", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        let collection14 = Collection(id: 14, nome: "Americanas", imagemDesbloqueada: "url_15", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "BBB", stickerScore: 20)
        
//                       model album
                       models.append(Model(id: 1, text: "BBB", imageName: "image_1", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5,collection6,collection7,collection8, collection9,collection10,collection11,collection12,collection13,collection14]))
                       models.append(Model(id: 2, text: "Tunel do amor", imageName: "image_2", imageDetails: "bbb1", figurinhas: [collection2,collection1]))
                       models.append(Model(id: 3, text: "No limite", imageName: "image_3", imageDetails: "bbb1", figurinhas: [collection1]))
                       models.append(Model(id: 4, text: "The voice", imageName: "image_4", imageDetails: "bbb1", figurinhas: [collection1]))
                       models.append(Model(id: 5, text: "The masked singer", imageName: "image_5", imageDetails: "bbb1", figurinhas: [collection1]))
       
                       //recents
        recents.append(ModelRecents(id: 1, nome: "RoBBB Mau", imagemDesbloqueada: "url_1", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "RoBBB Mau, a personificação do Castigo do Monstro. Nele, a produção determina ações desconfortáveis ao longo de todo um final de semana.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 2, nome: "McDonald’s", imagemDesbloqueada: "url_2", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Patrocinador oficial do BBB, transformando lanches em estrelas do reality show mais saboroso! Quem criará a próxima Méquizice surpreendente? 🍔✨", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 3, nome: "Karol Conká", imagemDesbloqueada: "url_3", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 4, nome: "Big Fone", imagemDesbloqueada: "url_4", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Elemento icônico do Big Brother Brasil que promete trazer uma surpresa para o jogo. Quem o atender pode ser imunizado, eliminado ou encaminhado ao paredão… tudo pode acontecer!", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 5, nome: "Pedro Bial", imagemDesbloqueada: "url_5", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 6, nome: "Tiago Leifert", imagemDesbloqueada: "url_6", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 7, nome: "Viih Tube", imagemDesbloqueada: "url_7", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 8, nome: "RoBBB Verde", imagemDesbloqueada: "url_8", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 9, nome: "RoBBB Rosa", imagemDesbloqueada: "url_9", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 10, nome: "RoBBB Azul", imagemDesbloqueada: "url_10", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 11, nome: "Juliette", imagemDesbloqueada: "url_11", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Juliette, a rainha do carisma, é uma advogada que virou fenômeno após vencer o BBB 21. Com sua simpatia, conquistou o país e virou meme oficial do Brasil!", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 12, nome: "RoBBB Anjo", imagemDesbloqueada: "url_12", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 13, nome: "Samsung", imagemDesbloqueada: "url_13", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 14, nome: "Americanas", imagemDesbloqueada: "url_14", imagemBloqueada: "imagemBloqueada", objetos: "Objetos", descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))



    }
    
    @objc func buttonSearchTapped() {
        print("Botão de pesquisar tocado!")
    }
    
    @objc func buttonProfileTapped() {
        // Ação a ser executada quando o botão é tocado
        print("Botão do perfil tocado!")
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
        return 200
    }

    
    


}

