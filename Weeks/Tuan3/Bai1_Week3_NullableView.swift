import SwiftUI

struct Bai1_Week3_NullableView: View {
    @State private var name: String? = nil
    @State private var input: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Bài 1 - Tuần 3 (Nullable / Optional)")
                .font(.headline)
                .padding(.top, 18)

            TextField("Nhập tên (có thể bỏ trống)", text: $input)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)

            HStack(spacing: 12) {
                Button("Gán") {
                    let t = input.trimmingCharacters(in: .whitespacesAndNewlines)
                    name = t.isEmpty ? nil : t
                }
                .buttonStyle(.borderedProminent)

                Button("Set nil") {
                    name = nil
                }
                .buttonStyle(.bordered)
            }

            Divider()

            // 1) if let
            GroupBox("1) if let (unwrap an toàn)") {
                if let n = name {
                    Text("Tên: \(n)")
                } else {
                    Text("name đang nil")
                        .foregroundColor(.secondary)
                }
            }

            // 2) Safe call ?.
            GroupBox("2) Safe call ?.") {
                Text("name?.count = \(name?.count ?? 0)")
            }

            // 3) ?? default value
            GroupBox("3) ?? (giá trị mặc định)") {
                Text("Hiển thị: \(name ?? "Chưa có tên")")
            }

            // 4) ! force unwrap (chỉ minh hoạ, tránh crash)
            GroupBox("4) ! (force unwrap) - minh hoạ") {
                if name != nil {
                    Text("name!.count = \(name!.count)")
                } else {
                    Text("Không dùng name! vì sẽ crash")
                        .foregroundColor(.red)
                }
            }

            Spacer()
        }
        .padding(16)
        .onTapGesture { hideKeyboard() }
    }

    private func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
        #endif
    }
}
