import SwiftUI

struct Bai1_Week2: View {
    @State private var inputText: String = ""
    @State private var errorText: String? = nil
    @State private var numbers: [Int] = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Bài 1 - Tuần 2")
                .font(.headline)
                .padding(.top, 24)

            HStack(spacing: 12) {
                TextField("Nhập vào số lượng", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)

                Button("Tạo") {
                    createList()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)

            if let errorText {
                Text(errorText)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(numbers, id: \.self) { n in
                        Text("\(n)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
            }

            Spacer()
        }
        .onTapGesture { hideKeyboard() }
    }

    private func createList() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let n = Int(trimmed), n > 0 else {
            errorText = "Dữ liệu bạn nhập không hợp lệ"
            numbers = []
            return
        }

        errorText = nil
        numbers = Array(1...min(n, 100))
    }

    private func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
        #endif
    }
}
