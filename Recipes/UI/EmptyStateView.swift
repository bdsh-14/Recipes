import SwiftUI

struct EmptyStateView: View {
    var body: some View {
		ZStack {
			Color(.brown).opacity(0.3).ignoresSafeArea()
			VStack {
				Image(systemName: "exclamationmark.icloud")
					.resizable()
					.fontWeight(.ultraLight)
					.scaledToFit()
					.frame(height: 80)
				Text("No items found! \n Please check in later.")
					.font(.title3)
					.fontWeight(.semibold)
					.multilineTextAlignment(.center)
					.foregroundStyle(Color.brown)
					.padding()
			}
		}
    }
}

#Preview {
    EmptyStateView()
}
