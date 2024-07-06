import XCTest
@testable import Recipes

class MealDetailViewModelTests: XCTestCase {
	var viewModel: MealDetailViewModel!
	var mockNetworkManager: MockNetworkManager!

	override func setUp() {
		super.setUp()
		mockNetworkManager = MockNetworkManager()
		viewModel = MealDetailViewModel(networkManager: mockNetworkManager)
	}

	override func tearDown() {
		viewModel = nil
		mockNetworkManager = nil
		super.tearDown()
	}

	func testFetchMealDetailsSuccess() async {
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
		await viewModel.fetchMealDetails(for: "123")

		// Then
		XCTAssertEqual(viewModel.mealDetail?.idMeal, "123")
		XCTAssertEqual(viewModel.mealDetail?.strMeal, "Test Meal")
		//XCTAssertFalse(viewModel.isLoading)
	}
	func testFetchMealDetailsFailure() async {
		// Given
		mockNetworkManager.shouldReturnError = true
		// When
		await viewModel.fetchMealDetails(for: "123")

		// Then
		XCTAssertNil(viewModel.mealDetail)
		//XCTAssertFalse(viewModel.isLoading)
	}
}
