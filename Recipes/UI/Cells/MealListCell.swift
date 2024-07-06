import SwiftUI

struct MealListCell: View {
	let meal: Meal

    var body: some View {
		ZStack {
			VStack {
				MealImageView(imageUrl: meal.strMealThumb)

				Text("\(meal.strMeal)")
					.foregroundStyle(.secondary)
					.fontWeight(.bold)
			}
			.padding([.bottom])
		}
    }
}

#Preview {
	MealListCell(meal: Meal(strMeal: "Ice creams",
							strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
							idMeal: "52893"))
}
