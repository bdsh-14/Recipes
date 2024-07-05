import Foundation

extension String {
	var toInt: Int {
		Int(self) ?? -1
	}
}
