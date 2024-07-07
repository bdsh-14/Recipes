import Foundation

@MainActor
class MealsListViewModel: ObservableObject {
	@Published var state: MealsListViewState = .loading

	private var networkManager: NetworkManagerInterface

	init(networkManager: NetworkManagerInterface = NetworkManager.shared) {
		self.networkManager = networkManager
	}

	func fetchAllMeals() async {
		state = .loading
		do {
			let meals = try await networkManager.fetchAllMeals()
			state = meals.isEmpty ? .empty : .loaded(meals.sorted(by: { $0.strMeal < $1.strMeal }))
		}
		catch {
			state = .error(error.localizedDescription)
		}
	}
}
