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

class CustomBarButton: UIBarButtonItem {
    convenience init(image: UIImage, target: Any?, action: Selector?) {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action ?? "", for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32) // Ajuste o tamanho conforme necessário
        
        self.init(customView: button)
    }
}



