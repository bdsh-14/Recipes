import XCTest
@testable import Recipes

class MealsListViewModelTests: XCTestCase {
	var mockViewModel: MealsListViewModel!
	var mockNetworkManager: MockNetworkManager!

	@MainActor override func setUp() {
		super.setUp()
		mockNetworkManager = MockNetworkManager()
		mockViewModel = MealsListViewModel(networkManager: mockNetworkManager)
	}

	override func tearDown() {
		mockViewModel = nil
		mockNetworkManager = nil
		super.tearDown()
	}

	@MainActor
	func test_fetchAllMeals_sorted_alphabetically() async {
		// Given
		let meal_1 = Meal(strMeal: "Ice cream sandwich",
						  strMealThumb: "https://ice-cream-sandwich",
						  idMeal: "123")
		let meal_2 = Meal(strMeal: "Creme brulee",
						  strMealThumb: "https://creme-brulee",
						  idMeal: "456")
		mockNetworkManager.meals = [meal_1, meal_2]

		// When
		await mockViewModel.fetchAllMeals()

		// Then
		XCTAssertEqual(mockViewModel.meals.count, 2)
		XCTAssertEqual(mockViewModel.meals[0].strMeal, "Creme brulee")
		XCTAssertEqual(mockViewModel.meals[0].strMealThumb, "https://creme-brulee")
		XCTAssertEqual(mockViewModel.meals[0].idMeal, "456")
		XCTAssertEqual(mockViewModel.meals[1].strMeal, "Ice cream sandwich")
		XCTAssertEqual(mockViewModel.meals[1].strMealThumb, "https://ice-cream-sandwich")
		XCTAssertEqual(mockViewModel.meals[1].idMeal, "123")
	}

	@MainActor
	func testFetchMealDetailsFailure() async {
		// Given
		mockNetworkManager.shouldReturnError = true
		// When
		await mockViewModel.fetchAllMeals()

		// Then
		XCTAssertEqual(mockViewModel.meals.count, 0)
		XCTAssertFalse(mockViewModel.isLoading)
	}
}

