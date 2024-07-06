import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealListViewModel()

	var body: some View {
		ZStack {
			NavigationView {
				List(viewModel.meals) { meal in
					NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
						Text("Go to detail view")
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