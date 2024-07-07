import SwiftUI

struct MealDetailView: View {
	@StateObject private var viewModel = MealDetailViewModel()
	let mealId: String
	let mealName: String
	@State private var ingredientsExpanded = false
	@State private var instructionsExpanded = false

	var body: some View {
		NavigationStack {
			ZStack {
				Color.brown.opacity(0.4).ignoresSafeArea()
				VStack {
					if let mealDetail = viewModel.mealDetail {
						MealImageView(imageUrl: mealDetail.strMealThumb)
							.padding(.bottom)
						List {
							DisclosureGroup("Ingredients", isExpanded: $ingredientsExpanded) {
								IngredientsCell(ingredientsMeasurements: mealDetail.ingredientMeasurements)
							}
							.modifier(ExpandableRowStyle())
							DisclosureGroup("Instructions", isExpanded: $instructionsExpanded) {
								InstructionsCell(instructions: mealDetail.strInstructions)
							}
							.modifier(ExpandableRowStyle())
						}
						.listStyle(.plain)
					}
				}
				.padding()
				.navigationTitle(mealName)
				.task {
					await viewModel.fetchMealDetails(for: mealId)
				}
				if viewModel.isLoading {
					LoadingView().ignoresSafeArea([.all])
				}
			}
		}
	}
}

#Preview {
	MealDetailView(mealId: "52856", mealName: "Ice-cream")
}
