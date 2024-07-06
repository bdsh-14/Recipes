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
	let (mealId, mealName): (String, String)
	@State private var selection: String?
	@State private var items: [Item] = [
		Item(title: "Ingredients", section: .ingredients),
		Item(title: "Instructions", section: .instructions)
	]

	var body: some View {
		VStack {
			if let mealDetail = viewModel.mealDetail {
				MealImageView(imageUrl: mealDetail.strMealThumb)
					.padding(.bottom)

				List {
					ForEach($items) { $item in
						VStack {
							HStack {
								Text(item.title)
									.font(.title3)
									.fontWeight(.medium)
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
						.listRowBackground(Color.clear)
					}
				}
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
