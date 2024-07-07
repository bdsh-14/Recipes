import SwiftUI

struct MealsListLoadedView: View {
	let meals: [Meal]

	var body: some View {
		List(meals) { meal in
			NavigationLink(destination: MealDetailView(mealId: meal.idMeal,
													   mealName: meal.strMeal)) {
				MealListCell(meal: meal)
			}
			 .listRowBackground(Color.clear)
			 .listRowSeparator(.hidden)
		}
		.scrollContentBackground(.hidden)
		.listStyle(.plain)
	}
}

#Preview {
    MealsListLoadedView(meals: [])
}
