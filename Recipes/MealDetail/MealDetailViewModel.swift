import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
	@Published var mealDetail: MealDetail?
	@Published var isLoading: Bool = false

	private var networkManager: NetworkManagerInterface


	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func fetchMealDetails(for mealId: String) async {
		isLoading = true
		do {
			let meals = try await networkManager.fetchMealDetails(for: mealId.toInt)
			self.mealDetail = meals.first
		} catch {
			print(error)
		}
		isLoading = false
	}
}
