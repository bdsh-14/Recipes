import Foundation

class MealListViewModel: ObservableObject {
	@Published var meals: [Meal] = []

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
