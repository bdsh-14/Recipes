import Foundation
@testable import Recipes

class MockNetworkManager: NetworkManagerInterface {
	var shouldReturnError = false
	var mealDetails: [MealDetail] = []
	var meals: [Meal] = []

	func fetchAllMeals() async throws -> [Recipes.Meal] {
		if shouldReturnError {
			throw URLError(.badServerResponse)
		}
		return meals
	}

	func fetchMealDetails(for mealId: Int) async throws -> [MealDetail] {
		if shouldReturnError {
			throw URLError(.badServerResponse)
		}
		return mealDetails
	}
}
