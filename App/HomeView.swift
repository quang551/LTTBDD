import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Tuần 1") { Week1MenuView() }
                NavigationLink("Tuần 2") { Week2MenuView() }
                NavigationLink("Tuần 3") { Week3MenuView() }
            }
            .navigationTitle("LTTBDD")
        }
    }
}
