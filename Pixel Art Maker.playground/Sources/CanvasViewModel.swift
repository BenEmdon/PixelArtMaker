import UIKit

protocol CanvasDelegate: class {
	func colorChanged(newPixelState pixelState: PixelState)
	func clearCanvas()
}

public struct CanvasState {
	let state: Set<PixelState>
}

public struct PixelState: Hashable {
	let x: Int
	let y: Int
	let color: UIColor

	public var hashValue: Int {
		return "\(x)\(y)\(color)".hashValue
	}

	/// Returns a Boolean value indicating whether two values are equal.
	///
	/// Equality is the inverse of inequality. For any values `a` and `b`,
	/// `a == b` implies that `a != b` is `false`.
	///
	/// - Parameters:
	///   - lhs: A value to compare.
	///   - rhs: Another value to compare.
	public static func ==(lhs: PixelState, rhs: PixelState) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.color == rhs.color
	}
}

struct CanvasViewModel {
	private var stateHistory: Array<CanvasState>
	private var currentDraw: Set<PixelState>
	private var undoneChanges: Array<CanvasState>
	weak var delegate: CanvasDelegate?

	init(initialState: CanvasViewModel? = nil) {
		stateHistory = []
		currentDraw = []
		undoneChanges = []
	}

	mutating func drawAt(x: Int, y: Int, color: UIColor) {
		let pixelState = PixelState(x: x, y: y, color: color)
		let (inserted, _) = currentDraw.insert(pixelState)
		if inserted {
			undoneChanges = []
			delegate?.colorChanged(newPixelState: pixelState)
		}
	}

	mutating func endDrawing() {
		stateHistory.append(CanvasState(state: currentDraw))
		currentDraw = []
	}

	struct Point: Hashable {
		let x: Int
		let y: Int

		public var hashValue: Int {
			return "\(x),\(y)".hashValue
		}

		public static func ==(lhs: Point, rhs: Point) -> Bool {
			return lhs.x == rhs.x && lhs.y == rhs.y
		}
	}

	mutating func undo() {
		guard let lastDraw = stateHistory.popLast() else { return }

		delegate?.clearCanvas()
		for state in stateHistory {
			apply(canvasState: state)
		}
		undoneChanges.append(lastDraw)
	}

	mutating func redo() {
		guard let lastUndoneDraw = undoneChanges.popLast() else { return }
		apply(canvasState: lastUndoneDraw)
		stateHistory.append(lastUndoneDraw)
	}

	mutating func apply(canvasState: CanvasState) {
		for pixelState in canvasState.state {
			delegate?.colorChanged(newPixelState: pixelState)
		}
	}
}

