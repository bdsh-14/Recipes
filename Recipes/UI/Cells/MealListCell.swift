import SwiftUI

struct MealListCell: View {
	let meal: Meal

	var body: some View {
		VStack {
			MealImageView(imageUrl: meal.strMealThumb)
				.padding(.bottom)

			Text("\(meal.strMeal)")
				.font(.title2)
				.foregroundStyle(.secondary)
				.fontWeight(.bold)
		}
		.padding([.bottom])
		.border(Color.brown)
		.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
	}
}

#Preview {
	MealListCell(meal: Meal(strMeal: "Ice creams",
							strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
							idMeal: "52893"))
}
