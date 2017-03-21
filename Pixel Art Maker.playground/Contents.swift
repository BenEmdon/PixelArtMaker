import UIKit
import PlaygroundSupport

let pixelSize: CGFloat = 15
let heightInPixels: Int = 20
let canvasDefaultColor: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
let colors: [UIColor] = [.white, .blue, .red, .green, .purple, .black, .darkGray]

let pixelArtMaker = CanvasController(
	width: heightInPixels,
	height: heightInPixels,
	pixelSize: pixelSize,
	canvasColor: canvasDefaultColor,
	colors: colors,
	theme: .dark)

PlaygroundPage.current.liveView = pixelArtMaker
