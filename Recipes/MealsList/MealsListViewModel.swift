import Foundation

class MealsListViewModel: ObservableObject {
	@Published var meals: [Meal] = []
	@Published var isLoading: Bool = false

	private var networkManager: NetworkManagerInterface

	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func fetchAllMeals() {
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
