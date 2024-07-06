import XCTest
@testable import Recipes

final class MealsListViewModelTests: XCTestCase {
	var viewModel: MealsListViewModel!
	var mockNetworkManager: MockNetworkManager!

	override func setUp() {
		super.setUp()
		mockNetworkManager = MockNetworkManager()
		viewModel = MealsListViewModel(networkManager: mockNetworkManager)
	}

	override func tearDown() {
		viewModel = nil
		mockNetworkManager = nil
		super.tearDown()
	}

	func test_fetchAllMeals() async {
		// Given
		let meal_1 = Meal(strMeal: "Ice cream sandwich",
						strMealThumb: "https://ice-cream-sandwich",
						idMeal: "123")
		let meal_2 = Meal(strMeal: "Creme brulee",
						  strMealThumb: "https://creme-brulee",
						  idMeal: "456")

		mockNetworkManager.meals = [meal_1, meal_2]

		// When
		await viewModel.fetchAllMeals()

		// Then
		XCTAssertEqual(viewModel.meals[0].strMeal, "Ice cream sandwich")
		XCTAssertEqual(viewModel.meals[0].strMealThumb, "https://ice-cream-sandwich")
		XCTAssertEqual(viewModel.meals[0].idMeal, "123")
		XCTAssertEqual(viewModel.meals[1].strMeal, "Creme brulee")
		XCTAssertEqual(viewModel.meals[1].strMealThumb, "https://creme-brulee")
		XCTAssertEqual(viewModel.meals[1].idMeal, "456")
	}
}
