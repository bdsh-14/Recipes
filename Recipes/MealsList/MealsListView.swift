import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealListViewModel()

	var body: some View {
		ZStack {
			NavigationView {
				List(viewModel.meals) { meal in
					NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
						Text("Go to detail view")
					NavigationLink(destination: MealDetailView(mealId: meal.idMeal, mealName: meal.strMeal)) {
						MealListCell(meal: meal)
					}
					MealListCell(meal: meal)
				}
				.navigationTitle("🍨 Meals")
			}
			.onAppear {
				viewModel.getMeals()
			}
		}
	}
}

#Preview {
    MealsListView()
}
