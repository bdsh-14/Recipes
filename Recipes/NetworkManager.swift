import Foundation

final class NetworkManager {
	static let shared = NetworkManager()

	private init() { }

	func fetchAllMeals() async throws -> [Meal] {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "themealdb.com"
		components.path = "/api/json/v1/1/filter.php"
		components.queryItems = [
			URLQueryItem(name: "c", value: "Dessert")
		]
		guard let url = components.url else { preconditionFailure("Invalid URL string") }

		let (data, response) = try await URLSession.shared.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}

		let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
		return mealsResponse.meals
	}

	func fetchMealDetails(for mealId: Int) async throws -> [MealDetail] {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "themealdb.com"
		components.path = "/api/json/v1/1/lookup.php"
		components.queryItems = [
			URLQueryItem(name: "i", value: "\(mealId)")
		]
		guard let url = components.url else { preconditionFailure("Invalid URL string") }

		let (data, response) = try await URLSession.shared.data(from: url)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}

		let mealData = try JSONDecoder().decode(MealDetailResponse.self, from: data)
		return mealData.meals
	}
}
