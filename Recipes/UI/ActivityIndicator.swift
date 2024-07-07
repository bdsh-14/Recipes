import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
	func makeUIView(context: Context) -> UIActivityIndicatorView {
		let activityIndicatorView = UIActivityIndicatorView(style: .large)
		activityIndicatorView.color = .systemBrown
		activityIndicatorView.startAnimating()
		return activityIndicatorView
	}
	
	func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) { }
}

struct LoadingView: View {
	var body: some View {
		ZStack {
			Color.brown.opacity(0.4).ignoresSafeArea()
			ActivityIndicator()
		}
	}
}
