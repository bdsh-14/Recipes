import SwiftUI

struct MealDetailView: View {
	@StateObject var viewModel = MealDetailViewModel()
	let (mealId, mealName): (String, String)
	@State private var ingredientsExpanded = false
	@State private var instructionsExpanded = false

	var body: some View {
		VStack {
			if let mealDetail = viewModel.mealDetail {
				MealImageView(imageUrl: mealDetail.strMealThumb)
					.padding(.bottom)
				List {
					DisclosureGroup("Ingredients", isExpanded: $ingredientsExpanded) {
						IngredientsCell(ingredients: mealDetail.ingredients, measurements: mealDetail.measures)
					}
					.modifier(ExpandableRowStyle())
					DisclosureGroup("Instructions", isExpanded: $instructionsExpanded) {
						InstructionsCell(instructions: mealDetail.strInstructions)
					}
					.modifier(ExpandableRowStyle())
				}
				.scrollContentBackground(.hidden)
				.listStyle(.plain)
			}
		}
		.navigationBarTitle(mealName)
		.onAppear {
			viewModel.fetchMealDetails(for: mealId)
		}
		.padding()
		.background {
			Color.brown.opacity(0.4).ignoresSafeArea()
		}
	}
}

#Preview {
	MealDetailView(mealId: "52856", mealName: "Ice-cream")
}
