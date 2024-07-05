import SwiftUI

struct MealDetailView: View {
	@StateObject var viewModel = MealDetailViewModel()
	let mealId: String

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 10) {
				if let mealDetail = viewModel.mealDetail {

					// Meal Image
					MealRemoteImage(urlString: mealDetail.strMealThumb)
						.aspectRatio(contentMode: .fill)
						.frame(width: 120, height: 120)
						.cornerRadius(8)

					// Ingredients and Measurements
					IngredientsCell(ingredients: mealDetail.ingredients,
									measurements: mealDetail.measures)
					// Instructions
					InstructionsCell(instructions: mealDetail.strInstructions)
				}
			}
			.onAppear {
				viewModel.fetchMealDetails(for: mealId)
			}
			.padding()
		}
	}
}

#Preview {
	MealDetailView(mealId: "52856")
}
