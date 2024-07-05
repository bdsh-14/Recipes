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
					VStack(alignment: .leading) {
						Text("Ingredients")
							.font(.headline)

						ForEach(Array(zip(mealDetail.ingredients, mealDetail.measures)), id: \.0) { ingredient, measure in
							HStack {
								Text(ingredient)
									.font(.body)
								Spacer()
								Text(measure)
									.font(.body)
									.foregroundColor(.secondary)
							}
							.padding(.vertical, 2)
						}
					}
					// Instructions
					Text("Instructions")
						.font(.headline)
					Text(mealDetail.strInstructions)
						.padding(.top, 4)
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
