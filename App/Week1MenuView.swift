import SwiftUI

struct Week1MenuView: View {
    var body: some View {
        List {
            NavigationLink("Bài 1 – Profile UI") {
                Bai1()
            }
        }
        .navigationTitle("Tuần 1")
    }
}
