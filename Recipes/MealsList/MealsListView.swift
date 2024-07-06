import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealsListViewModel()

	var body: some View {
		NavigationStack {
			ZStack {
				Color.brown.opacity(0.4).ignoresSafeArea()
				List(viewModel.meals) { meal in
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
			.navigationTitle("🥘 Meals")
		}
		.onAppear {
			Task {
				await viewModel.fetchAllMeals()
			}
		}
	}
}

#Preview {
    MealsListView()
}
