import SwiftUI

struct MealsListView: View {
	@StateObject var viewModel = MealsListViewModel()

	var body: some View {
		NavigationStack {
			ZStack {
				Color.brown.opacity(0.4).ignoresSafeArea()

				switch viewModel.state {
				case .loading:
					LoadingView()
				case .empty:
					EmptyStateView()
				case .loaded(let meals):
					MealsListLoadedView(meals: meals)
				case .error(let message):
					ErrorView(message: message)
				}
			}
			.navigationTitle("🥘 Meals")
		}
		.task {
			await viewModel.fetchAllMeals()
		}
	}
}

enum MealsListViewState: Equatable {
	case loading
	case empty
	case loaded([Meal])
	case error(String)
}

#Preview {
	MealsListView()
}
