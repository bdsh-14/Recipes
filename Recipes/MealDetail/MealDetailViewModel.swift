import Foundation

class MealDetailViewModel: ObservableObject {
	@Published var mealDetail: MealDetail?

	func fetchMealDetails(for mealId: String) {
		Task {
			do {
				let meals = try await NetworkManager.shared.fetchMealDetails(for: mealId.toInt)
				self.mealDetail = meals.first
			} catch {
				print(error)
			}
		}
	}
}
