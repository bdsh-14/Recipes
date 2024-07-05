import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealListViewModel()
	@State var isShowingDetail: Bool = false

	var body: some View {
		ZStack {
			NavigationView {
				List(viewModel.meals) { meal in
					NavigationLink(destination: MealDetailView()) {
						Text("Go to detail view")
					}
					MealListCell(meal: meal)
				}
				.navigationTitle("🍨 Meals")
			}
			.onAppear {
				viewModel.getMeals()
			}

			if isShowingDetail {
				MealDetailView()
			}
		}
	}
}

#Preview {
    MealsListView()
}
