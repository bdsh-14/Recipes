import UIKit

protocol NetworkManagerInterface {
	func fetchAllMeals() async throws -> [Meal]
	func fetchMealDetails(for mealId: Int) async throws -> [MealDetail]
	func downloadImage(from urlString: String) async throws -> UIImage?
}

final class NetworkManager: NetworkManagerInterface {
	static let shared = NetworkManager()
	private let cache = NSCache<NSString, UIImage>()

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

	func downloadImage(from urlString: String) async throws -> UIImage? {
		let key = NSString(string: urlString)
		if let image = cache.object(forKey: key) {
			return image
		}
		guard let url = URL(string: urlString) else { return nil }
		let (data, _) = try await URLSession.shared.data(from: url)
		guard let image = UIImage(data: data) else { return nil }
		cache.setObject(image, forKey: key)
		return image
	}
}
