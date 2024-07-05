import SwiftUI

final class ImageLoader: ObservableObject {
	@Published var image: Image? = nil

	func load(from urlString: String) {
		Task {
			let uiImage = try await NetworkManager.shared.downloadImage(from: urlString)
			guard let uiImage else { return }
			self.image = Image(uiImage: uiImage)
		}
	}
}

struct RemoteImage: View {
	var image: Image?
	var body: some View {
		image?.resizable() ?? Image(systemName: "fork.knife").resizable()
	}
}

struct MealRemoteImage: View {
	@StateObject var imageLoader = ImageLoader()
	let urlString: String

	var body: some View {
		RemoteImage(image: imageLoader.image)
			.onAppear {
				imageLoader.load(from: urlString)
			}
	}
}
