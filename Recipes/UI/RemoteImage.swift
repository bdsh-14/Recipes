import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
	@Published var image: Image? = nil
	private var networkManager: NetworkManagerInterface

	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func load(from urlString: String) {
		Task {
			let uiImage = try await networkManager.downloadImage(from: urlString)
			guard let uiImage else { return }
			self.image = Image(uiImage: uiImage)
		}
	}
}

struct RemoteImage: View {
	var image: Image?
	var body: some View {
		image?.resizable() ?? Image(systemName: "fork.knife")
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
