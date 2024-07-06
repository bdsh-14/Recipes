import XCTest
@testable import Recipes

class MealDetailViewModelTests: XCTestCase {
	var mockViewModel: MealDetailViewModel!
	var mockNetworkManager: MockNetworkManager!

	override func setUp() {
		super.setUp()
		mockNetworkManager = MockNetworkManager()
	}

	override func tearDown() {
		mockViewModel = nil
		mockNetworkManager = nil
		super.tearDown()
	}

	@MainActor
	func setupViewModel() {
		mockViewModel = MealDetailViewModel(networkManager: mockNetworkManager)
	}

	@MainActor
	func testFetchMealDetailsSuccess() async {
		setupViewModel()
		// Given
		let mealDetail = MealDetail(
			idMeal: "123",
			strMeal: "Test Meal",
			strCategory: "Test Category",
			strArea: "Test Area",
			strInstructions: "Test Instructions",
			strMealThumb: "Test URL",
			ingredients: ["Ingredient 1"],
			measures: ["Measure 1"]
		)
		mockNetworkManager.mealDetails = [mealDetail]

		// When
		await mockViewModel.fetchMealDetails(for: "123")

		// Then
		XCTAssertEqual(mockViewModel.mealDetail?.idMeal, "123")
		XCTAssertEqual(mockViewModel.mealDetail?.strMeal, "Test Meal")
		XCTAssertFalse(mockViewModel.isLoading)
	}

	@MainActor
	func testFetchMealDetailsFailure() async {
		setupViewModel()
		// Given
		mockNetworkManager.shouldReturnError = true
		// When
		await mockViewModel.fetchMealDetails(for: "123")

		// Then
		XCTAssertNil(mockViewModel.mealDetail)
		XCTAssertFalse(mockViewModel.isLoading)
	}
}
