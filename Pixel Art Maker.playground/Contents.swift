import UIKit
import PlaygroundSupport

typealias PixelArtMaker = CanvasController
class CanvasController: UIView {
	let canvas: Canvas
	let pallet: Pallet
	let width: Int
	let height: Int
	let pixelSize: CGFloat
	var colorPallet: [UIColor] = []

	var currentPaintBrush = UIColor.darkGray {
		didSet {
			canvas.paintBrushColor = currentPaintBrush
		}
	}

	init(width: Int, height: Int, pixelSize: CGFloat, colors: [UIColor]) {
		self.width = width
		self.height = height
		self.pixelSize = pixelSize
		canvas = Canvas(width: width, height: height, pixelSize: pixelSize)
		pallet = Pallet(colors: colors, width: width)
		super.init(frame: CGRect(x: 0, y: 0, width:  CGFloat(width) * pixelSize + 40, height: CGFloat(height) * pixelSize + 80))

		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		backgroundColor = .white
		pallet.delegate = self
		addSubview(canvas)
		addSubview(pallet)
		canvas.frame.origin = CGPoint(x: Metrics.regular, y: Metrics.regular)
		pallet.frame.origin = CGPoint(x: Metrics.regular, y: pixelSize * CGFloat(height) + 2 * Metrics.regular)
	}
}

extension CanvasController: PalletDelegate {
	func paintBrushDidChange(color: UIColor) {
		currentPaintBrush = color
	}
}

protocol PalletDelegate: class {
	func paintBrushDidChange(color: UIColor)
}

class Pallet: UIView {
	let colors: [UIColor]
	let width: Int
	let height: Int
	var buttons = Array<UIButton>()

	weak var delegate: PalletDelegate?

	init(colors: [UIColor], width: Int) {
		self.colors = colors
		self.width = width
		height = colors.count / width + (colors.count % width == 0 ? 0 : 1) + 1
		super.init(frame: CGRect(
			x: 0,
			y: 0,
			width: CGFloat(max(width, 3)) * Metrics.regular,
			height: CGFloat(height) * Metrics.regular
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
		let verticalStackView = UIStackView()
		verticalStackView.axis = .vertical
		verticalStackView.distribution = .fillEqually
		verticalStackView.alignment = .leading


		var rowsOfColors: Array<Array<UIColor>> = []
		for (index, color) in colors.enumerated() {
			if index % width == 0 {
				rowsOfColors.append([])
			}
			rowsOfColors[index / width].append(color)
		}

		for row in rowsOfColors {
			let horizontalStackView = UIStackView()
			horizontalStackView.axis = .horizontal
			horizontalStackView.distribution = .fillEqually
			horizontalStackView.alignment = .leading

			for color in row {
				let button = UIButton(frame: CGRect(x: 0, y: 0, width: Metrics.regular, height: Metrics.regular))
				button.backgroundColor = color
				button.layer.borderColor = UIColor.yellow.cgColor
				button.addTarget(self, action: #selector(handleColorSelected(sender:)), for: .touchUpInside)
				buttons.append(button)
				horizontalStackView.addArrangedSubview(button)
			}
			verticalStackView.addArrangedSubview(horizontalStackView)
		}

		addSubview(verticalStackView)
		verticalStackView.frame = bounds
	}

	func handleColorSelected(sender: UIButton) {
		sender.layer.borderWidth = 1
		delegate?.paintBrushDidChange(color: sender.backgroundColor!)
	}

}

let pixelSize: CGFloat = 15
let heightInPixels: Int = 20
let canvasDefaultColor: UIColor = .white

let pixelArtMaker = PixelArtMaker(width: heightInPixels, height: heightInPixels, pixelSize: pixelSize, colors: [.white, .blue, .red])

PlaygroundPage.current.liveView = pixelArtMaker
