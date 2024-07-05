import Foundation

class MealDetailViewModel: ObservableObject {
	@Published var mealDetail: MealDetail?

	func fetchMealDetails() {
		Task {
			do {
				let meals = try await NetworkManager.shared.fetchMealDetails()
				self.mealDetail = meals.first
			} catch {
				print(error)
			}
		}
	}
}
