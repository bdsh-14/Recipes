import Foundation

@MainActor
class MealsListViewModel: ObservableObject {
	@Published var meals: [Meal] = []
	@Published var isLoading: Bool = false

	private var networkManager: NetworkManagerInterface

	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func fetchAllMeals() async {
		isLoading = true
		do {
			let meals = try await networkManager.fetchAllMeals()
			self.meals = meals.sorted(by: { $0.strMeal < $1.strMeal })
		}
		catch {
			print(error)
		}
		isLoading = false
	}
}
