import UIKit

public class Canvas: UIView {
	class Pixel: UIView {
	}

	var pixels: Array<Array<Pixel>>!
	let width: Int
	let height: Int
	let pixelSize: CGFloat
	let canvasDefaultColor: UIColor
	public var paintBrushColor = UIColor.black
	var viewModel: CanvasViewModel
	var lastTouched = Set<Pixel>()

	public init(width: Int, height: Int, pixelSize: CGFloat, canvasColor: UIColor) {
		self.width = width
		self.height = height
		self.pixelSize = pixelSize
		canvasDefaultColor = canvasColor
		viewModel = CanvasViewModel()
		super.init(frame: CGRect(x: 0, y: 0, width:  CGFloat(width) * pixelSize, height: CGFloat(height) * pixelSize))
		viewModel.delegate = self
		setupView()
	}

	required public init?(coder aDecoder: NSCoder) {
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

	private func setupView() {

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDrag(sender:)))
		tapGestureRecognizer.delegate = self

		let dragGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleDrag(sender:)))
		dragGestureRecognizer.minimumPressDuration = 0
		addGestureRecognizer(dragGestureRecognizer)

		pixels = []
		for heightIndex in 0..<height {
			pixels.append([])
			for widthIndex in 0..<width {
				let pixel = createPixel(defaultColor: canvasDefaultColor)
				pixel.frame = CGRect(
					x: CGFloat(widthIndex) * pixelSize,
					y: CGFloat(heightIndex) * pixelSize,
					width: pixelSize,
					height: pixelSize
				)
				pixels[heightIndex].append(pixel)
				addSubview(pixel)
			}
		}
		isUserInteractionEnabled = true
	}

	private func createPixel(defaultColor: UIColor) -> Pixel {
		let pixel = Pixel()
		pixel.backgroundColor = defaultColor
		pixel.layer.borderWidth = 0.5
		pixel.layer.borderColor = UIColor.lightGray.cgColor
		pixel.isUserInteractionEnabled = false
		return pixel
	}

	private dynamic func handleDrag(sender: UIGestureRecognizer) {
		switch sender.state {
		case .began, .changed:
			draw(atPoint: sender.location(in: self))
		case .ended:
			draw(atPoint: sender.location(in: self))
			viewModel.endDrawing()
		default: break
		}
	}

	private func draw(atPoint point: CGPoint) {
		let y = Int(point.y / pixelSize)
		let x = Int(point.x / pixelSize)
		guard y < height && x < width && y >= 0 && x >= 0 else { return }
		viewModel.drawAt(x: x, y: y, color: paintBrushColor)
	}

	private func removeGrid() {
		for row in pixels {
			for pixel in row {
				pixel.layer.borderWidth = 0
			}
		}
	}

	private func addGrid() {
		for row in pixels {
			for pixel in row {
				pixel.layer.borderWidth = 0.5
			}
		}
	}

	func makeImageFromSelf() -> UIImage {
		removeGrid()
		UIGraphicsBeginImageContext(self.frame.size)
		layer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		addGrid()
		return image!
	}
}

extension Canvas: CanvasDelegate {
	func colorChanged(newPixelState pixelState: PixelState) {
		pixels[pixelState.y][pixelState.x].backgroundColor = pixelState.color
	}

	func clearCanvas() {
		for row in pixels {
			for pixel in row {
				pixel.backgroundColor = canvasDefaultColor
			}
		}
	}
}

extension Canvas: UIGestureRecognizerDelegate {
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
