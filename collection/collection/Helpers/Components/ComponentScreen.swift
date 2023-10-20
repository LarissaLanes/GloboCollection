import UIKit

class ComponentScreen: UIView {
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

        // Configurações do UILabel
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
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



