import SwiftUI

struct Week2MenuView: View {
    var body: some View {
        List {
            NavigationLink("Bài 1 – Tuần 2 (Nhập số tạo danh sách)") {
                Bai1_Week2()
            }
            NavigationLink("Bài 2 – Tuần 2 (Calculator)") {
                Bai2_Week2()
            }
        }
        .navigationTitle("Tuần 2")
    }
}
