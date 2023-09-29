import UIKit

class ComponentScreen: UIView {
    // Elementos de interface de usuário
    let imageView = UIImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        // Configurações da UIImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        // Configure as restrições de layout para a UIImageView conforme necessário

        // Configurações do UILabel
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        // Configure as restrições de layout para o UILabel conforme necessário
    }
}
