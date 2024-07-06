import UIKit
@testable import Recipes

final class MockNetworkManager: NetworkManagerInterface {
	var shouldReturnError = false
	var mealDetails: [MealDetail] = []
	var meals: [Meal] = []

	func fetchAllMeals() async throws -> [Meal] {
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

	func downloadImage(from urlString: String) async throws -> UIImage? {
		return UIImage()
	}
}
