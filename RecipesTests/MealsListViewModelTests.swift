import XCTest
@testable import Recipes

final class MealsListViewModelTests: XCTestCase {
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
	func test_fetchAllMeals_loadingState() async {
		// Given
		mockNetworkManager.meals = []

		// When
		await mockViewModel.fetchAllMeals()

		// Then
		if case .loading = mockViewModel.state {
			XCTFail("Expected state to be loading initially")
		}
	}

	@MainActor
	func test_fetchAllMeals_sorted_alphabetically() async {
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
		if case let .loaded(meals) = mockViewModel.state {
			XCTAssertEqual(meals.count, 2)
			XCTAssertEqual(meals[0].strMeal, "Creme brulee")
			XCTAssertEqual(meals[0].strMealThumb, "https://creme-brulee")
			XCTAssertEqual(meals[0].idMeal, "456")
			XCTAssertEqual(meals[1].strMeal, "Ice cream sandwich")
			XCTAssertEqual(meals[1].strMealThumb, "https://ice-cream-sandwich")
			XCTAssertEqual(meals[1].idMeal, "123")
		}
	}

	@MainActor
	func test_fetchAllMeals_emptyState() async {
		// Given
		mockNetworkManager.meals = []

		// When
		await mockViewModel.fetchAllMeals()

		// Then
		if case .empty = mockViewModel.state {
			// Success
		} else {
			XCTFail("Expected state to be empty")
		}
	}

	@MainActor
	func testFetchAllMealsFailure() async {
		// Given
		mockNetworkManager.shouldReturnError = true

		// When
		await mockViewModel.fetchAllMeals()

		// Then
		if case let .error(errorMessage) = mockViewModel.state {
			XCTAssertNotNil(errorMessage)
		} else {
			XCTFail("Expected state to be error")
		}
	}
}

