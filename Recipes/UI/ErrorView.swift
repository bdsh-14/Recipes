import SwiftUI

struct ErrorView: View {
	let message: String

	var body: some View {
		VStack {
			Text("Error")
				.font(.title)
				.padding(.bottom, 10)
			Text(message)
				.multilineTextAlignment(.center)
		}
		.padding()
	}
}
