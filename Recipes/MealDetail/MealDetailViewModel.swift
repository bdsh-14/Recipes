import Foundation

class MealDetailViewModel: ObservableObject {
	@Published var mealDetail: MealDetail?
	private var networkManager: NetworkManagerInterface

	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func fetchMealDetails(for mealId: String) {
		Task {
			do {
				let meals = try await networkManager.fetchMealDetails(for: mealId.toInt)
				self.mealDetail = meals.first
			} catch {
				print(error)
			}
		}
	}
}
