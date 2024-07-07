import Foundation

struct Meal: Decodable, Identifiable, Equatable {
	let strMeal: String
	let strMealThumb: String
	let idMeal: String

	var id: String {
		idMeal
	}
}

struct MealsResponse: Decodable {
	let meals: [Meal]
}
