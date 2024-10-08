import SwiftUI

struct MealImageView: View {
	let imageUrl: String

    var body: some View {
		MealRemoteImage(urlString: imageUrl)
			.aspectRatio(contentMode: .fill)
			.frame(maxWidth: .infinity, minHeight: 80, maxHeight: 150)
			.cornerRadius(8)
			.shadow(radius: 8)
    }
}

#Preview {
	MealImageView(imageUrl: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")
}
