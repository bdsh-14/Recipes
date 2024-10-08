import Foundation

struct MealDetailResponse: Decodable {
	let meals: [MealDetail]
}

struct IngredientMeasurement: Identifiable {
	let id = UUID()
	let ingredient: String
	let measurement: String
}

struct MealDetail: Decodable {
	let idMeal: String
	let strMeal: String
	let strDrinkAlternate: String?
	let strCategory: String
	let strArea: String
	let strInstructions: String
	let strMealThumb: String
	let strTags: String?
	let strYoutube: String?
	let ingredientMeasurements: [IngredientMeasurement]
	let strSource: String?
	let strImageSource: String?
	let strCreativeCommonsConfirmed: String?
	let dateModified: String?

	enum CodingKeys: String, CodingKey {
		case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
		case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
		case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		idMeal = try container.decode(String.self, forKey: .idMeal)
		strMeal = try container.decode(String.self, forKey: .strMeal)
		strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
		strCategory = try container.decode(String.self, forKey: .strCategory)
		strArea = try container.decode(String.self, forKey: .strArea)
		strInstructions = try container.decode(String.self, forKey: .strInstructions)
		strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
		strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
		strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
		strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
		strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
		strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
		dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)

		var ingredients = [String]()
		var measurements = [String]()

		for i in 1...20 {
			if let ingredient = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\(i)")!) {
				if !ingredient.isEmpty {
					ingredients.append(ingredient)
				}
			}

			if let measure = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\(i)")!) {
				if !measure.isEmpty {
					measurements.append(measure)
				}
			}
		}

		ingredientMeasurements = zip(ingredients, measurements).map { IngredientMeasurement(ingredient: $0, measurement: $1) }
	}
}

extension MealDetail {
	init(idMeal: String, strMeal: String, strDrinkAlternate: String? = nil, strCategory: String, strArea: String, strInstructions: String, strMealThumb: String, strTags: String? = nil, strYoutube: String? = nil, ingredients: [String], measures: [String], strSource: String? = nil, strImageSource: String? = nil, strCreativeCommonsConfirmed: String? = nil, dateModified: String? = nil) {
		self.idMeal = idMeal
		self.strMeal = strMeal
		self.strDrinkAlternate = strDrinkAlternate
		self.strCategory = strCategory
		self.strArea = strArea
		self.strInstructions = strInstructions
		self.strMealThumb = strMealThumb
		self.strTags = strTags
		self.strYoutube = strYoutube
		self.ingredientMeasurements = [IngredientMeasurement(ingredient: "Butter", measurement: "60g")]
		self.strSource = strSource
		self.strImageSource = strImageSource
		self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
		self.dateModified = dateModified
	}
}
