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
    let categoria: String
    let raridade: Bool
    let descricao: String
    let album: String
    let stickerScore: Int
    
    init(id: Int, nome: String, imagemDesbloqueada: String, imagemBloqueada: String, categoria: String, raridade: Bool, descricao: String, album: String, stickerScore: Int) {
        self.id = id
        self.nome = nome
        self.imagemDesbloqueada = imagemDesbloqueada
        self.imagemBloqueada = imagemBloqueada
        self.categoria = categoria
        self.raridade = raridade
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
    let categoria: String
    let raridade: Bool
    let descricao: String
    let album: String
    let stickerScore: Int // Adicione esta propriedade

    init(id: Int, nome: String, imagemDesbloqueada: String, imagemBloqueada: String, categoria: String, raridade: Bool, descricao: String, album: String, stickerScore: Int) {
        self.id = id
        self.nome = nome
        self.imagemDesbloqueada = imagemDesbloqueada
        self.imagemBloqueada = imagemBloqueada
        self.categoria = categoria
        self.raridade = raridade
        self.descricao = descricao
        self.album = album
        self.stickerScore = stickerScore
    }
}

class CollectionViewController: UIViewController {
    
    var models = [Model]()
    var recents = [ModelRecents]()
    var selectedRow = 0
    var data = [[RecentTableViewCell()],[CollectionTableViewCell()]]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage
 
        let componentScreen = ComponentScreen()
        componentScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(componentScreen)
        
        componentScreen.imageView.image = UIImage(named: "globoCollectionLogo")
        componentScreen.label.text = "Seu álbum de melhores momentos."
        componentScreen.label.textColor = .white

        NSLayoutConstraint.activate([
            componentScreen.imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            componentScreen.imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            componentScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            componentScreen.label.topAnchor.constraint(equalTo: componentScreen.imageView.bottomAnchor, constant: 20),
            componentScreen.label.leadingAnchor.constraint(equalTo: componentScreen.imageView.leadingAnchor),
            componentScreen.label.trailingAnchor.constraint(equalTo: componentScreen.imageView.trailingAnchor),
        ])
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroundPage
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: componentScreen.label.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
      
        let collection1 = Collection(id: 1, nome: "RoBBB Mau", imagemDesbloqueada: "url_1", imagemBloqueada: "urlBloq_1", categoria: "RobBBB", raridade: true, descricao: "RoBBB Mau, a personificação do Castigo do Monstro. Nele, a produção determina ações desconfortáveis ao longo de todo um final de semana.", album: "BBB", stickerScore: 10)
        let collection2 = Collection(id: 2, nome: "McDonald’s", imagemDesbloqueada: "url_2", imagemBloqueada: "urlBloq_2", categoria: "Patrocinadores", raridade: true, descricao: "Patrocinador oficial do BBB, transformando lanches em estrelas do reality show mais saboroso! Quem criará a próxima Méquizice surpreendente? 🍔✨", album: "BBB", stickerScore: 10)
        let collection3 = Collection(id: 3, nome: "Karol Conká", imagemDesbloqueada: "url_3", imagemBloqueada: "urlBloq_3", categoria: "Brothers", raridade: false, descricao: "Figurinha icônica representando a cantora Karol Conká.", album: "BBB", stickerScore: 20)
        let collection4 = Collection(id: 4, nome: "Big Fone", imagemDesbloqueada: "url_4", imagemBloqueada: "urlBloq_4", categoria: "Objetos", raridade: false, descricao: "Elemento icônico do Big Brother Brasil que promete trazer uma surpresa para o jogo. Quem o atender pode ser imunizado, eliminado ou encaminhado ao paredão… tudo pode acontecer!", album: "BBB", stickerScore: 10)
        let collection5 = Collection(id: 5, nome: "Pedro Bial", imagemDesbloqueada: "url_5", imagemBloqueada: "urlBloq_5", categoria: "Apresentadores", raridade: false, descricao: "Figurinha do querido Ex apresentador Pedro Bial.", album: "BBB", stickerScore: 20)
        let collection6 = Collection(id: 6, nome: "Tiago Leifert", imagemDesbloqueada: "url_6", imagemBloqueada: "urlBloq_6", categoria: "Apresentadores", raridade: false, descricao: "Figurinha do apresentador Tiago Leifert.", album: "BBB", stickerScore: 20)
        let collection7 = Collection(id: 7, nome: "Viih Tube", imagemDesbloqueada: "url_7", imagemBloqueada: "urlBloq_7",categoria: "Brothers", raridade: false, descricao: "Figurinha da blogueira e ex BBB Viih Tube.", album: "BBB", stickerScore: 20)
        let collection8 = Collection(id: 8, nome: "RoBBB Verde", imagemDesbloqueada: "url_8", imagemBloqueada: "urlBloq_8", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Verde.", album: "BBB", stickerScore: 20)
        let collection9 = Collection(id: 9, nome: "RoBBB Rosa", imagemDesbloqueada: "url_9", imagemBloqueada: "urlBloq_9", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Rosa", album: "BBB", stickerScore: 20)
        let collection10 = Collection(id: 10, nome: "RoBBB Azul", imagemDesbloqueada: "url_10", imagemBloqueada: "urlBloq_10", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Azul", album: "BBB", stickerScore: 20)
        let collection11 = Collection(id: 11, nome: "Juliette", imagemDesbloqueada: "url_11", imagemBloqueada: "urlBloq_11", categoria: "Brothers", raridade: false, descricao: "Juliette, a rainha do carisma, é uma advogada que virou fenômeno após vencer o BBB 21. Com sua simpatia, conquistou o país e virou meme oficial do Brasil!", album: "BBB", stickerScore: 20)
        let collection12 = Collection(id: 12, nome: "RoBBB Anjo", imagemDesbloqueada: "url_12", imagemBloqueada: "urlBloq_12", categoria: "RobBBB", raridade: true, descricao: "Figurinha icônica representando o RoBBB Anjo.", album: "BBB", stickerScore: 20)
        let collection13 = Collection(id: 13, nome: "Samsung", imagemDesbloqueada: "url_13", imagemBloqueada: "urlBloq_13", categoria: "Patrocinadores", raridade: true, descricao: "Figurinha do querido parceiro samsung", album: "BBB", stickerScore: 20)
        let collection14 = Collection(id: 14, nome: "Americanas", imagemDesbloqueada: "url_14", imagemBloqueada: "urlBloq_14", categoria: "Patrocinadores", raridade: true, descricao: "Parceira do BBB a mais de 6 anos", album: "BBB", stickerScore: 20)
        let collection15 = Collection(id: 15, nome: "Gil do Vigor", imagemDesbloqueada: "url_15", imagemBloqueada: "urlBloq_15", categoria: "Brothers", raridade: false, descricao: "Gil do Vigor, ex-participante do Big Brother Brasil, é conhecido por sua autenticidade, alegria contagiante e luta pela representatividade LGBTQ+. Ele é um exemplo de resiliência e carisma.", album: "BBB", stickerScore: 10 )
        let collection16 = Collection(id: 16, nome: "Fiuk", imagemDesbloqueada: "url_16", imagemBloqueada: "urlBloq_16", categoria: "Brothers", raridade: false, descricao: "Fiuk é um talentoso artista e músico. Sua personalidade autêntica e paixão pela música o tornaram um dos queridinhos do público brasileiro.", album: "BBB", stickerScore: 10 )
        let collection17 = Collection(id: 17, nome: "Tadeu Schmidt", imagemDesbloqueada: "url_17", imagemBloqueada: "urlBloq_17", categoria: "Apresentadores", raridade: false, descricao: "Tadeu Schmidt é um conhecido apresentador de televisão brasileiro. Ele é amplamente reconhecido por seu trabalho como apresentador do programa 'Fantástico', exibido aos domingos na Rede Globo. Com sua carisma e profissionalismo, Tadeu Schmidt se tornou uma figura querida na televisão brasileira, trazendo notícias, entretenimento e informação para milhões de telespectadores.", album: "BBB", stickerScore: 10 )
        let collection18 = Collection(id: 18, nome: "RoBBB Roxo", imagemDesbloqueada: "url_18", imagemBloqueada: "urlBloq_18", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Roxo", album: "BBB", stickerScore: 10 )
        let collection19 = Collection(id: 19, nome: "Lais", imagemDesbloqueada: "url_19", imagemBloqueada: "urlBloq_19", categoria: "Brothers", raridade: false, descricao: "Ex participante BBB", album: "BBB", stickerScore: 10 )
        let collection20 = Collection(id: 20, nome: "Nego Di", imagemDesbloqueada: "url_20", imagemBloqueada: "urlBloq_20", categoria: "Brothers", raridade: false, descricao: "Nego Di é um comediante brasileiro que ganhou notoriedade como ex-participante do Big Brother Brasil 21. Sua presença carismática e estilo humorístico o destacaram no programa", album: "BBB", stickerScore: 10 )
        let collection21 = Collection(id: 21, nome: "João Luiz", imagemDesbloqueada: "url_21", imagemBloqueada: "urlBloq_21", categoria: "Brothers", raridade: false, descricao: "Ex BBB21 professor universitario que marcou sendo uma plantinha!", album: "BBB", stickerScore: 10 )
        let collection22 = Collection(id: 22, nome: "Rafael Portugal", imagemDesbloqueada: "url_22", imagemBloqueada: "urlBloq_22", categoria: "Apresentadores", raridade: false, descricao: "Rafael Portugal é um humorista e apresentador brasileiro famoso por seu trabalho em programas de comédia. Conhecido por seu estilo humorístico único, ele se destacou no 'A Culpa é do Cabral' e pelo 'CAT BBB'. Além da televisão, é um renomado comediante de stand-up.", album: "BBB", stickerScore: 10 )
        let collection23 = Collection(id: 23, nome: "Dani Calabresa", imagemDesbloqueada: "url_23", imagemBloqueada: "urlBloq_23", categoria: "Apresentadores", raridade: false, descricao: "Comediante talentosa conhecida por seu humor icônico.", album: "BBB", stickerScore: 10)
        let collection24 = Collection(id: 24, nome: "Paulo Vieira", imagemDesbloqueada: "url_24", imagemBloqueada: "urlBloq_24", categoria: "Apresentadores", raridade: false, descricao: "Versátil humorista e roteirista de destaque.", album: "BBB", stickerScore: 10)
        let collection25 = Collection(id: 25, nome: "Chevrolet", imagemDesbloqueada: "url_25", imagemBloqueada: "urlBloq_25", categoria: "Patrocinadores", raridade: true, descricao: "Marca patrocinadora do BBB, presente em muitas edições.", album: "BBB", stickerScore: 20)
        let collection26 = Collection(id: 26, nome: "Mercado Livre", imagemDesbloqueada: "url_26", imagemBloqueada: "urlBloq_26", categoria: "Patrocinadores", raridade: true, descricao: "Importante parceiro de e-commerce do programa.", album: "BBB", stickerScore: 20)
        let collection27 = Collection(id: 27, nome: "RoBBB Amarelo", imagemDesbloqueada: "url_27", imagemBloqueada: "urlBloq_27", categoria: "RoBBB", raridade: false, descricao: "Figurinha representando o icônico RoBBB Amarelo.", album: "BBB", stickerScore: 10)
        let collection28 = Collection(id: 28, nome: "Marisa Orth", imagemDesbloqueada: "url_28", imagemBloqueada: "urlBloq_28", categoria: "Apresentadores", raridade: false, descricao: "Talentosa atriz e apresentadora de televisão.", album: "BBB", stickerScore: 10)

           models.append(Model(id: 1, text: "BBB", imageName: "image_1", imageDetails: "bbb1", figurinhas: [collection1,collection2,collection3,collection4,collection5,collection6,collection7,collection8, collection9,collection10,collection11,collection12,collection13,collection14,collection15,collection16,collection17,collection18,collection19,collection20,collection21,collection22,collection23,collection24,collection25,collection26,collection27,collection28]))
           models.append(Model(id: 2, text: "Tunel do amor", imageName: "image_2", imageDetails: "bbb1", figurinhas: []))
           models.append(Model(id: 3, text: "No limite", imageName: "image_3", imageDetails: "bbb1", figurinhas: []))
           models.append(Model(id: 4, text: "The voice", imageName: "image_4", imageDetails: "bbb1", figurinhas: []))
           models.append(Model(id: 5, text: "The masked singer", imageName: "image_5", imageDetails: "bbb1", figurinhas: []))
       
        recents.append(ModelRecents(id: 1, nome: "RoBBB Mau", imagemDesbloqueada: "url_1", imagemBloqueada: "urlBloq_1", categoria: "RobBBB", raridade: true, descricao: "RoBBB Mau, a personificação do Castigo do Monstro. Nele, a produção determina ações desconfortáveis ao longo de todo um final de semana.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 2, nome: "McDonald’s", imagemDesbloqueada: "url_2", imagemBloqueada: "urlBloq_2", categoria: "Patrocinadores", raridade: true, descricao: "Patrocinador oficial do BBB, transformando lanches em estrelas do reality show mais saboroso! Quem criará a próxima Méquizice surpreendente? 🍔✨", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 3, nome: "Karol Conká", imagemDesbloqueada: "url_3", imagemBloqueada: "urlBloq_3", categoria: "Brothers", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 4, nome: "Big Fone", imagemDesbloqueada: "url_4", imagemBloqueada: "urlBloq_4", categoria: "Objetos", raridade: false, descricao: "Elemento icônico do Big Brother Brasil que promete trazer uma surpresa para o jogo. Quem o atender pode ser imunizado, eliminado ou encaminhado ao paredão… tudo pode acontecer!", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 5, nome: "Pedro Bial", imagemDesbloqueada: "url_5", imagemBloqueada: "urlBloq_5", categoria: "Apresentadores", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 6, nome: "Tiago Leifert", imagemDesbloqueada: "url_6", imagemBloqueada: "urlBloq_6", categoria: "Apresentadores", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 7, nome: "Viih Tube", imagemDesbloqueada: "url_7", imagemBloqueada: "urlBloq_7", categoria: "Brothers", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 8, nome: "RoBBB Verde", imagemDesbloqueada: "url_8", imagemBloqueada: "urlBloq_8", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 9, nome: "RoBBB Rosa", imagemDesbloqueada: "url_9", imagemBloqueada: "urlBloq_9", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 10, nome: "RoBBB Azul", imagemDesbloqueada: "url_10", imagemBloqueada: "urlBloq_10", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 11, nome: "Juliette", imagemDesbloqueada: "url_11", imagemBloqueada: "urlBloq_11", categoria: "Brothers", raridade: false, descricao: "Juliette, a rainha do carisma, é uma advogada que virou fenômeno após vencer o BBB 21. Com sua simpatia, conquistou o país e virou meme oficial do Brasil!", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 12, nome: "RoBBB Anjo", imagemDesbloqueada: "url_12", imagemBloqueada: "urlBloq_12", categoria: "RobBBB", raridade: true, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 13, nome: "Samsung", imagemDesbloqueada: "url_13", imagemBloqueada: "urlBloq_13", categoria: "Patrocinadores", raridade: true, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 14, nome: "Americanas", imagemDesbloqueada: "url_14", imagemBloqueada: "urlBloq_14", categoria: "Patrocinadores", raridade: true, descricao: "Figurinha icônica representando o RoBBB Mau, a personificação do Castigo do Monstro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 15, nome: "Gil do Vigor", imagemDesbloqueada: "url_15", imagemBloqueada: "urlBloq_15", categoria: "Brothers", raridade: false, descricao: "Gil do Vigor, ex-participante do Big Brother Brasil, é conhecido por sua autenticidade, alegria contagiante e luta pela representatividade LGBTQ+. Ele é um exemplo de resiliência e carisma.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 16, nome: "Fiuk", imagemDesbloqueada: "url_16", imagemBloqueada: "urlBloq_16", categoria: "Brothers", raridade: false, descricao: "Fiuk é um talentoso artista e músico. Sua personalidade autêntica e paixão pela música o tornaram um dos queridinhos do público brasileiro.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 17, nome: "Tadeu Schmidt", imagemDesbloqueada: "url_17", imagemBloqueada: "urlBloq_17", categoria: "Apresentadores", raridade: false, descricao: "Tadeu Schmidt é um conhecido apresentador de televisão brasileiro. Ele é amplamente reconhecido por seu trabalho como apresentador do programa 'Fantástico', exibido aos domingos na Rede Globo. Com sua carisma e profissionalismo, Tadeu Schmidt se tornou uma figura querida na televisão brasileira, trazendo notícias, entretenimento e informação para milhões de telespectadores.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 18, nome: "RoBBB Roxo", imagemDesbloqueada: "url_18", imagemBloqueada: "urlBloq_18", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Roxo", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 19, nome: "Lais", imagemDesbloqueada: "url_19", imagemBloqueada: "urlBloq_19", categoria: "Brothers", raridade: false, descricao: "Ex participante BBB", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 20, nome: "Nego Di", imagemDesbloqueada: "url_20", imagemBloqueada: "urlBloq_20", categoria: "Brothers", raridade: false, descricao: "Nego Di é um comediante brasileiro que ganhou notoriedade como ex-participante do Big Brother Brasil 21. Sua presença carismática e estilo humorístico o destacaram no programa", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 21, nome: "João Luiz", imagemDesbloqueada: "url_21", imagemBloqueada: "urlBloq_21", categoria: "Brothers", raridade: false, descricao: "Ex BBB21 professor universitario que marcou sendo uma plantinha!", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 22, nome: "Rafael Portugal", imagemDesbloqueada: "url_22", imagemBloqueada: "urlBloq_22", categoria: "Apresentadores", raridade: false, descricao: "Rafael Portugal é um humorista e apresentador brasileiro famoso por seu trabalho em programas de comédia. Conhecido por seu estilo humorístico único, ele se destacou no 'A Culpa é do Cabral' e pelo 'CAT BBB'. Além da televisão, é um renomado comediante de stand-up.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 23, nome: "Dani Calabresa", imagemDesbloqueada: "url_23", imagemBloqueada: "urlBloq_23", categoria: "Apresentadores", raridade: false, descricao: "Comediante talentosa conhecida por seu humor icônico.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 24, nome: "Paulo Vieira", imagemDesbloqueada: "url_24", imagemBloqueada: "urlBloq_24", categoria: "Apresentadores", raridade: false, descricao: "Versátil humorista e roteirista de destaque.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 25, nome: "Chevrolet", imagemDesbloqueada: "url_25", imagemBloqueada: "urlBloq_25", categoria: "Patrocinadores", raridade: true, descricao: "Marca patrocinadora do BBB, presente em muitas edições.", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 26, nome: "Mercado Livre", imagemDesbloqueada: "url_26", imagemBloqueada: "urlBloq_26", categoria: "Patrocinadores", raridade: true, descricao: "Importante parceiro de e-commerce do programa.", album: "bbb", stickerScore: 10))
                       recents.append(ModelRecents(id: 27, nome: "RoBBB Amarelo", imagemDesbloqueada: "url_27", imagemBloqueada: "urlBloq_27", categoria: "RobBBB", raridade: false, descricao: "Figurinha icônica representando o RoBBB Amarelo", album: "bbb", stickerScore: 10))
        recents.append(ModelRecents(id: 28, nome: "Glória Maria", imagemDesbloqueada: "url_28", imagemBloqueada: "urlBloq_28", categoria: "Apresentadores", raridade: false, descricao: "Uma das jornalistas mais renomadas do Brasil.", album: "bbb", stickerScore: 10))
    }
    
    @objc func buttonSearchTapped() {
        print("Botão de pesquisar tocado!")
    }
    
    @objc func buttonProfileTapped() {
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
