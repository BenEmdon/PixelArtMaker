import UIKit
import PlaygroundSupport

//: ![mario](Mario.jpg)
//: ### COOL
let marioColorSet = [#colorLiteral(red: 0.9260939956, green: 0.7393692136, blue: 0.535525322, alpha: 1), #colorLiteral(red: 0.8486657143, green: 0.1457175612, blue: 0.1098935679, alpha: 1), #colorLiteral(red: 0.03515542299, green: 0.0390829891, blue: 0.04739325494, alpha: 1), #colorLiteral(red: 0.2316169739, green: 0.252183795, blue: 0.6651875973, alpha: 1), #colorLiteral(red: 0.5066443086, green: 0.2547130287, blue: 0.1472603977, alpha: 1), #colorLiteral(red: 0.8298331499, green: 0.7703962922, blue: 0.1196306571, alpha: 1)]

let benColorSet = [#colorLiteral(red: 1, green: 0.8869820837, blue: 0.7137309097, alpha: 1), #colorLiteral(red: 0.5702336431, green: 0.7469733357, blue: 0.8845283389, alpha: 1), #colorLiteral(red: 0.03515542299, green: 0.0390829891, blue: 0.04739325494, alpha: 1), #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1), #colorLiteral(red: 0.5075009424, green: 0.2946772792, blue: 0.1519830821, alpha: 1), #colorLiteral(red: 0.9870286584, green: 0.8794633746, blue: 0.7908019423, alpha: 1), #colorLiteral(red: 0.7835152745, green: 0.3807955086, blue: 0.4221667051, alpha: 1), #colorLiteral(red: 0.6703479405, green: 0.3896099235, blue: 0.2029382737, alpha: 1),]

let pixelSize: CGFloat = 15
let heightInPixels: Int = 31
let canvasDefaultColor: UIColor = #colorLiteral(red: 1, green: 0.6332477699, blue: 0.7159463751, alpha: 1)
let colors: [UIColor] = benColorSet

let path = playgroundSharedDataDirectory.appendingPathComponent("Ben.jpg")

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
