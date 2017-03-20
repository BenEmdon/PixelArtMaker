import UIKit
import PlaygroundSupport

let pixelSize: CGFloat = 15
let heightInPixels: Int = 20
let canvasDefaultColor: UIColor = .white

let pixelArtMaker = PixelArtMaker(width: heightInPixels, height: heightInPixels, pixelSize: pixelSize, canvasColor: .white, colors: [.white, .blue, .red, .green, .purple, .black, .darkGray])

PlaygroundPage.current.liveView = pixelArtMaker
