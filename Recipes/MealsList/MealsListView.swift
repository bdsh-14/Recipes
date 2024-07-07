import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealsListViewModel()

	var body: some View {
		NavigationStack {
			ZStack {
				Color.brown.opacity(0.4).ignoresSafeArea()

				if viewModel.isLoading {
					LoadingView()
				}
				else if viewModel.meals.isEmpty {
					EmptyStateView()
				}
				else {
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
			}
			.navigationTitle("🥘 Meals")
		}
		.task {
			await viewModel.fetchAllMeals()
		}
//		if viewModel.isLoading {
//			LoadingView()
//		}
//		if viewModel.meals.isEmpty {
//			EmptyStateView().ignoresSafeArea([.all])
//		}
	}
}

#Preview {
    MealsListView()
}
