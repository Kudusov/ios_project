import UIKit

class CustomTimeCafeMarker: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(label)
        self.addSubview(imageView)
    }

    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    var imageView = UIImageView()
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        return label
    }()

}
