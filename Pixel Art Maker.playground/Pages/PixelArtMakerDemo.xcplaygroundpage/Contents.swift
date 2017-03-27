import UIKit
import PlaygroundSupport

//: ![Mario](Mario.jpg)
let marioColorPallet = [#colorLiteral(red: 0.9260939956, green: 0.7393692136, blue: 0.535525322, alpha: 1), #colorLiteral(red: 0.8486657143, green: 0.1457175612, blue: 0.1098935679, alpha: 1), #colorLiteral(red: 0.03515542299, green: 0.0390829891, blue: 0.04739325494, alpha: 1), #colorLiteral(red: 0.2316169739, green: 0.252183795, blue: 0.6651875973, alpha: 1), #colorLiteral(red: 0.5066443086, green: 0.2547130287, blue: 0.1472603977, alpha: 1), #colorLiteral(red: 0.8298331499, green: 0.7703962922, blue: 0.1196306571, alpha: 1)]
//: ![Apple](Apple.jpg)
let appleLogoColorPallet = [#colorLiteral(red: 0.9319646955, green: 0.1334255934, blue: 0.1326510012, alpha: 1), #colorLiteral(red: 0.2898080647, green: 0.03988443315, blue: 0.03802879527, alpha: 1), #colorLiteral(red: 0.9332934022, green: 0.5342146754, blue: 0.2673675418, alpha: 1), #colorLiteral(red: 0.4786225557, green: 0.2711006403, blue: 0.1341979504, alpha: 1), #colorLiteral(red: 0.9492279887, green: 0.7960495353, blue: 0.4377158582, alpha: 1), #colorLiteral(red: 0.5441896915, green: 0.4260497093, blue: 0.1513271332, alpha: 1), #colorLiteral(red: 0.6013671756, green: 0.7315731645, blue: 0.1352686286, alpha: 1), #colorLiteral(red: 0.1738204658, green: 0.2733283043, blue: 0.001983167371, alpha: 1), #colorLiteral(red: 0.2009291649, green: 0.4018282294, blue: 0.6674943566, alpha: 1), #colorLiteral(red: 0.09352166206, green: 0.1855295897, blue: 0.3100581169, alpha: 1), #colorLiteral(red: 0.3591453135, green: 0.2413133681, blue: 0.3027350307, alpha: 1), #colorLiteral(red: 0.1978913844, green: 0.09638027102, blue: 0.1455260813, alpha: 1)]
//: ![Heart](Heart.jpg)
let heartColorPallet = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9876473546, green: 0.02191194333, blue: 0.01887786761, alpha: 1)]

let pixelSize: CGFloat = 15
let heightWidth: Int = 15
let canvasDefaultColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let colorPallet: [UIColor] = heartColorPallet

let path = playgroundSharedDataDirectory.appendingPathComponent("MyArt.jpg")

let pixelArtMaker = CanvasController(
	width: heightWidth,
	height: heightWidth,
	pixelSize: pixelSize,
	canvasColor: canvasDefaultColor,
	colorPallet: colorPallet,
	theme: .dark,
	saveURL: path
)

PlaygroundPage.current.liveView = pixelArtMaker
