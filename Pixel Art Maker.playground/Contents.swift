import UIKit
import PlaygroundSupport

let marioColorSet = [#colorLiteral(red: 0.9260939956, green: 0.7393692136, blue: 0.535525322, alpha: 1), #colorLiteral(red: 0.8486657143, green: 0.1457175612, blue: 0.1098935679, alpha: 1), #colorLiteral(red: 0.03515542299, green: 0.0390829891, blue: 0.04739325494, alpha: 1), #colorLiteral(red: 0.2316169739, green: 0.252183795, blue: 0.6651875973, alpha: 1), #colorLiteral(red: 0.5066443086, green: 0.2547130287, blue: 0.1472603977, alpha: 1), #colorLiteral(red: 0.8298331499, green: 0.7703962922, blue: 0.1196306571, alpha: 1) ]

let pixelSize: CGFloat = 15
let heightInPixels: Int = 20
let canvasDefaultColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let colors: [UIColor] = marioColorSet

let path = playgroundSharedDataDirectory.appendingPathComponent("My-Pixel-Art.jpg")

let pixelArtMaker = CanvasController(
	width: heightInPixels,
	height: heightInPixels,
	pixelSize: pixelSize,
	canvasColor: canvasDefaultColor,
	colors: colors,
	theme: .dark,
	saveURL: path
)

PlaygroundPage.current.liveView = pixelArtMaker
