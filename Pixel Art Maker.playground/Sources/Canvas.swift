import UIKit

public class Canvas: UIView {
	class Pixel: UIView {
		override var backgroundColor: UIColor? {
			willSet {
				lastBackgroundColor = backgroundColor
			}
		}
		var lastBackgroundColor: UIColor? = nil
	}

	var pixels: Array<Array<Pixel>>!
	let width: Int
	let height: Int
	let pixelSize: CGFloat
	public var canvasDefaultColor = UIColor.white
	public var paintBrushColor = UIColor.black
	var lastTouched = Set<Pixel>()

	public init(width: Int, height: Int, pixelSize: CGFloat) {
		self.width = width
		self.height = height
		self.pixelSize = pixelSize
		super.init(frame: CGRect(x: 0, y: 0, width:  CGFloat(width) * pixelSize, height: CGFloat(height) * pixelSize))

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
		addGestureRecognizer(tapGestureRecognizer)

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
		case .began:
			lastTouched.removeAll()
		case .changed, .ended:
			guard let pixel = pixelFrom(point: sender.location(in: self)), !lastTouched.contains(pixel) else { return }
			pixel.backgroundColor = paintBrushColor
			lastTouched.insert(pixel)
		default: break
		}

	}

	private func pixelFrom(point: CGPoint) -> Pixel? {
		let heightIndex = Int(point.y / pixelSize)
		let widthIndex = Int(point.x / pixelSize)
		guard heightIndex < height && widthIndex < width && heightIndex >= 0 && widthIndex >= 0 else { return nil }
		return pixels[heightIndex][widthIndex]
	}
}

extension Canvas: UIGestureRecognizerDelegate {
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
