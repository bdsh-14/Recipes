import SwiftUI

struct MealsListView: View {
	@State private var meals: [Meal] = []

	var body: some View {
		NavigationView {
			List(meals) { meal in
				MealListCell(meal: meal)
			}
			.navigationTitle("🍨 Meals")
		}
		.onAppear {
			getMeals()
		}
	}

	func getMeals() {
		Task {
			do {
				let meals = try await NetworkManager.shared.fetchAllMeals()
				self.meals = meals
			}
			catch {
				print(error)
			}
		}
	}
}

#Preview {
    MealsListView()
}
