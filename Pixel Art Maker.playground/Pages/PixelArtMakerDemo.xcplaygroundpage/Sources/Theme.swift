import UIKit

/// Theme is a set of colors to be applied to the canvas environment to easy viewing. 
public enum Theme {
	case light
	case dark

	var mainColor: UIColor {
		switch self {
		case .light:
			return .lightGray
		case .dark:
			return Theme.xcodeDarkGray
		}
	}

	var accentColor: UIColor {
		switch self {
		case .light:
			return .white
		case .dark:
			return Theme.xcodeGray
		}
	}

	var palletDefaut: UIColor {
		switch self {
		case .light:
			return .lightGray
		case .dark:
			return .lightGray
		}
	}

	var palletSelected: UIColor {
		switch self {
		case .light:
			return Theme.xcodeDarkGray
		case .dark:
			return Theme.gold
		}
	}
	static var gold = UIColor(colorLiteralRed: 255/255, green: 251/255, blue: 0, alpha: 1)
	static var xcodeDarkGray = UIColor(colorLiteralRed: 40/255, green: 43/255, blue: 53/255, alpha: 1)
	static var xcodeGray = UIColor(colorLiteralRed: 63/255, green: 65/255, blue: 73/255, alpha: 1)
}
