import SwiftUI

struct IngredientsCell: View {
	let ingredients: [String]
	let measurements: [String]

    var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			ForEach(Array(zip(ingredients, measurements)), id: \.0) { ingredient, measure in
				HStack {
					Text(ingredient)
						.font(.body)
							.foregroundStyle(
								.linearGradient(
									colors: [.brown, .black],
									startPoint: .top,
									endPoint: .bottom
								)
							)
					Spacer()
					Text(measure)
						.font(.body)
						.foregroundColor(.secondary)
				}
				.padding([.leading, .trailing])
			}
		}
    }
}

#Preview {
	IngredientsCell(ingredients: ["Caster Sugar", "Plain Flour", "Butter"],
					measurements: ["60g", "120g", "60g"])
}
