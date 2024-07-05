import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
	func makeUIView(context: Context) -> UIActivityIndicatorView {
		let activityIndicatorView = UIActivityIndicatorView(style: .large)
		activityIndicatorView.color = .systemYellow
		activityIndicatorView.startAnimating()
		return activityIndicatorView
	}
	
	func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) { }
}

struct LoadingView: View {
	var body: some View {
		ZStack {
			Color(.secondarySystemBackground)
				.ignoresSafeArea(.all)
			ActivityIndicator()
		}
	}
}
