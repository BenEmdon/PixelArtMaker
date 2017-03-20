import UIKit

//public typealias PixelArtMaker = CanvasController
public class CanvasController: UIView {
	let canvas: Canvas
	let pallet: Pallet
	let width: Int
	let height: Int
	let pixelSize: CGFloat
	let colors: Array<UIColor>

	var currentPaintBrush: UIColor = .black {
		didSet {
			canvas.paintBrushColor = currentPaintBrush
		}
	}

	public init(width: Int, height: Int, pixelSize: CGFloat, canvasColor: UIColor, colors: Set<UIColor>) {
		self.width = width
		self.height = height
		self.pixelSize = pixelSize
		self.colors = Array(colors.filter{ $0 != canvasColor }) + [canvasColor]

		canvas = Canvas(width: width, height: height, pixelSize: pixelSize, canvasColor: canvasColor)
		pallet = Pallet(colors: self.colors)

		super.init(frame: CGRect(
			x: 0,
			y: 0,
			width:  CGFloat(width) * pixelSize + 80,
			height: max(canvas.bounds.height, pallet.bounds.height) + 40))

		setupViews()
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		if let startingPaintBrush = self.colors.first {
			currentPaintBrush = startingPaintBrush
		}

		backgroundColor = .white
		pallet.delegate = self
		addSubview(canvas)
		addSubview(pallet)
		canvas.frame.origin = CGPoint(x: Metrics.regular, y: Metrics.regular)
		pallet.frame.origin = CGPoint(x: CGFloat(width) * pixelSize + 30, y: Metrics.regular)
	}
}

extension CanvasController: PalletDelegate {
	func paintBrushDidChange(color: UIColor) {
		currentPaintBrush = color
	}
}
