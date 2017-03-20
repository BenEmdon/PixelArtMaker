import UIKit

protocol PalletDelegate: class {
	func paintBrushDidChange(color: UIColor)
}

class Pallet: UIView {
	let colors: [UIColor]
	var stackView: UIStackView!
	weak var delegate: PalletDelegate?

	init(colors: [UIColor]) {
		self.colors = colors
		super.init(frame: CGRect(
			x: 0,
			y: 0,
			width: Metrics.regular + 10,
			height: CGFloat(colors.count) * Metrics.regular + CGFloat(colors.count) + 10
			)
		)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public func layoutSubviews() {
		super.layoutSubviews()

		let shadowPath = UIBezierPath(rect: bounds)
		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
		layer.shadowOpacity = 0.5
		layer.shadowPath = shadowPath.cgPath
	}

	func setupViews() {
		backgroundColor = .white
		
		stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.spacing = 1

		for color in colors {
			let button = UIButton()
			button.backgroundColor = color
			button.layer.borderWidth = 1
			button.addTarget(self, action: #selector(handleColorSelected(sender:)), for: .touchUpInside)
			stackView.addArrangedSubview(button)
		}

		addSubview(stackView)
		stackView.frame = CGRect(
			x: 5,
			y: 5,
			width: bounds.width - 10,
			height: bounds.height - 10
		)
	}

	func handleColorSelected(sender: UIButton) {
		sender.layer.borderWidth = 1
		delegate?.paintBrushDidChange(color: sender.backgroundColor!)
	}
}
