import Foundation

struct Meal: Decodable, Identifiable {
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
