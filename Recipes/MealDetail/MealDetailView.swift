import SwiftUI

private struct Item: Identifiable {
	var id: Int { section.rawValue }
	let title: String
	var isExpanded: Bool = false
	let section: Section
}

private enum Section: Int {
	case ingredients
	case instructions
}

struct MealDetailView: View {
	@StateObject var viewModel = MealDetailViewModel()
	let mealId: String
	@State private var selection: String?
	@State private var items: [Item] = [
		Item(title: "Ingredients", section: .ingredients),
		Item(title: "Instructions", section: .instructions)
	]

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			if let mealDetail = viewModel.mealDetail {
				// Meal Image
				MealRemoteImage(urlString: mealDetail.strMealThumb)
					.aspectRatio(contentMode: .fill)
					.frame(width: 120, height: 120)
					.cornerRadius(8)

				List {
					ForEach($items) { $item in
						VStack {
							HStack {
								Text(item.title)
									.padding(.bottom)
								Spacer()
								Image(systemName: item.isExpanded ? "chevron.down" : "chevron.right")
							}
							.contentShape(Rectangle())
							.onTapGesture {
								item.isExpanded.toggle()
							}
							if item.isExpanded {
								switch item.section {
								case .ingredients:
									IngredientsCell(ingredients: mealDetail.ingredients,
													measurements: mealDetail.measures)
								case .instructions:
									InstructionsCell(instructions: mealDetail.strInstructions)
								}
							}
						}
						.padding()
					}
				}
				.listStyle(.insetGrouped)
			}
		}
		.navigationBarTitle(mealName)
		.onAppear {
			viewModel.fetchMealDetails(for: mealId)
		}
		.padding()
	}
}

#Preview {
	MealDetailView(mealId: "52856")
}
