import UIKit
import PlaygroundSupport

typealias PixelArtMaker = CanvasController
class CanvasController: UIView {
	let canvas: Canvas
	let width: Int
	let pixelSize: CGFloat
	var colorPallet: [UIColor] = []

	var currentPaintBrush = UIColor.darkGray {
		didSet {
			canvas.paintBrushColor = currentPaintBrush
		}
	}

	init(width: Int, height: Int, pixelSize: CGFloat) {
		self.width = width
		self.pixelSize = pixelSize
		canvas = Canvas(width: width, height: height, pixelSize: pixelSize)
		super.init(frame: CGRect(x: 0, y: 0, width:  CGFloat(width + 2) * pixelSize, height: CGFloat(height + 8) * pixelSize))

		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupViews() {
		backgroundColor = .white
		addSubview(canvas)
		canvas.frame.origin = CGPoint(x: pixelSize, y: pixelSize)
	}
}

let pixelSize: CGFloat = 20
let heightInPixels: Int = 10
let canvasDefaultColor: UIColor = .white

let pixelArtMaker = PixelArtMaker(width: heightInPixels, height: heightInPixels, pixelSize: pixelSize)

PlaygroundPage.current.liveView = pixelArtMaker