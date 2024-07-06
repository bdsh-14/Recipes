import XCTest
@testable import Recipes

final class NetworkManagerTests: XCTestCase {
	var networkManager: NetworkManager!
	var urlSession: URLSession!

	override func setUp() {
		super.setUp()

		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		urlSession = URLSession(configuration: configuration)

		networkManager = NetworkManager(session: urlSession)
	}

	override func tearDown() {
		networkManager = nil
		urlSession = nil
		super.tearDown()
	}

	func testFetchAllMeals() async throws {
		let mealsJSON = """
		{
			"meals": [
				{
					"strMeal": "Dessert1",
					"strMealThumb": "https://example.com/thumb1.jpg",
					"idMeal": "123"
				},
				{
					"strMeal": "Dessert2",
					"strMealThumb": "https://example.com/thumb2.jpg",
					"idMeal": "456"
				}
			]
		}
		"""
		let mockData = mealsJSON.data(using: .utf8)!
		MockURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(
				url: request.url!,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)!
			return (response, mockData)
		}
		let meals = try await networkManager.fetchAllMeals()

		XCTAssertEqual(meals.count, 2)
		XCTAssertEqual(meals[0].strMeal, "Dessert1")
		XCTAssertEqual(meals[1].strMeal, "Dessert2")
	}

	func testFetchMealDetails() async throws {
		let mealDetailJSON = """
		{
			"meals": [
				{
					"idMeal": "123",
					"strMeal": "Dessert1",
					"strDrinkAlternate": null,
					"strCategory": "Dessert",
					"strArea": "American",
					"strInstructions": "Mix ingredients.",
					"strMealThumb": "https://example.com/thumb1.jpg",
					"strIngredient1": "Single Cream",
					"strIngredient2": "Caster Sugar",
					"strMeasure1": "142ml",
					"strMeasure2": "25g",
				}
			]
		}
		"""
		let mockData = mealDetailJSON.data(using: .utf8)!
		MockURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(
				url: request.url!,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)!
			return (response, mockData)
		}
		let mealDetails = try await networkManager.fetchMealDetails(for: 123)

		XCTAssertEqual(mealDetails.count, 1)
		XCTAssertEqual(mealDetails[0].strMeal, "Dessert1")
		XCTAssertEqual(mealDetails[0].ingredientMeasurements.count, 2)
		XCTAssertEqual(mealDetails[0].ingredientMeasurements[0].ingredient, "Single Cream")
		XCTAssertEqual(mealDetails[0].ingredientMeasurements[0].measurement, "142ml")
		XCTAssertEqual(mealDetails[0].ingredientMeasurements[1].ingredient, "Caster Sugar")
		XCTAssertEqual(mealDetails[0].ingredientMeasurements[1].measurement, "25g")
	}

	func testDownloadImage() async throws {
		let imageUrlString = "https://example.com/thumb1.jpg"
		let image = UIImage(systemName: "star")!
		let imageData = image.pngData()!
		MockURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(
				url: request.url!,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)!
			return (response, imageData)
		}
		let downloadedImage = try await networkManager.downloadImage(from: imageUrlString)
		XCTAssertNotNil(downloadedImage)
	}
}
