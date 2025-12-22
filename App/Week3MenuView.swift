import SwiftUI

struct Week3MenuView: View {
    var body: some View {
        List {
            NavigationLink("Bài 1 – Nullable (Optional)") {
                Bai1_Week3_NullableView()
            }
            NavigationLink("Bài 2 – Chọn hình thức thanh toán (OOP)") {
                Bai2_Week3_PaymentView()
            }
            NavigationLink("Bài 3 – Quản lý thư viện") {
                Bai3_Week3_LibraryView()
            }
        }
        .navigationTitle("Tuần 3")
    }
}
