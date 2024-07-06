import SwiftUI

struct ExpandableRowStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.tint(.brown)
			.font(.title3)
			.fontWeight(.medium)
			.listRowBackground(Color.clear)
	}
}
