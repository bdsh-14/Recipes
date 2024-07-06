import Foundation

class MealsListViewModel: ObservableObject {
	@Published var meals: [Meal] = []
	@Published var isLoading: Bool = false

	func getMeals() {
		isLoading = true
		Task {
			isLoading = false
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
