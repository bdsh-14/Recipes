import SwiftUI

struct MealListCell: View {
	let meal: Meal

    var body: some View {
		VStack(alignment: .center, spacing: 8) {
			Image(systemName: "teddybear.fill")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 120, height: 120)
				.cornerRadius(8)
			Text("\(meal.strMeal)")
				.foregroundStyle(.secondary)
				.fontWeight(.semibold)
		}
    }
}

#Preview {
	MealListCell(meal: Meal(strMeal: "Ice creams",
							strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
							idMeal: "52893"))
}
