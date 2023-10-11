import UIKit

class GalerysTableViewCell: UITableViewCell {

    static let identifier = "GalerysTableViewCell"

    @IBOutlet var collectionView: UICollectionView!

    var collections: [Collection] = []

    func configure(with collections: [Collection]) {
        self.collections = collections
        collectionView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.backgroundColor = .backgroundPage

        // Configurar o layout da collectionView para exibir duas células por linha
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            let numberOfItemsPerRow: CGFloat = 3
            let spacingBetweenCells: CGFloat = 0 // Espaçamento entre as células

            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
            let itemWidth = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow

            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
//            flowLayout.minimumInteritemSpacing = spacingBetweenCells
//            flowLayout.minimumLineSpacing = spacingBetweenCells
            
            
        }

        collectionView.register(UINib(nibName: "CollectionItemCell", bundle: nil), forCellWithReuseIdentifier: "CollectionItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GalerysTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionItemCell", for: indexPath) as! CollectionItemCell

        let collection = collections[indexPath.item]
        cell.configure(with: collection)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCollection = collections[indexPath.item]

        // Crie uma instância do InfoViewController e configure-a com os dados da coleção selecionada
        let infoViewController = InfoViewController()
        infoViewController.collectionData = selectedCollection

        // Use o controlador de navegação existente para empurrar a InfoViewController na pilha
        if let navigationController = findNavigationController() {
            navigationController.pushViewController(infoViewController, animated: true)
        }
    }

    // Adicione essa função para encontrar o controlador de navegação pai
    func findNavigationController() -> UINavigationController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let navController = responder as? UINavigationController {
                return navController
            }
            responder = responder?.next
        }
        return nil
    }
}
