import SwiftUI

struct IngredientsCell: View {
	let ingredientsMeasurements: [IngredientMeasurement]

    var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			ForEach(ingredientsMeasurements) { item in
				HStack {
					Text(item.ingredient)
						.font(.body)
						.foregroundStyle(
							.linearGradient(
								colors: [.brown, .black],
								startPoint: .top,
								endPoint: .bottom
							)
						)
					Spacer()
					Text(item.measurement)
						.font(.body)
						.foregroundColor(.brown)
				}
			}
		}
    }
}

#Preview {
	IngredientsCell(ingredientsMeasurements: [.init(ingredient: "Butter", measurement: "60g")])
}
