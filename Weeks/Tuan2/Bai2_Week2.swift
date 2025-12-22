import SwiftUI

struct Bai2_Week2: View {

    enum Op: String, CaseIterable {
        case add = "+"
        case sub = "-"
        case mul = "*"
        case div = "/"
    }

    @State private var aText: String = ""
    @State private var bText: String = ""
    @State private var selectedOp: Op = .add

    private var resultText: String {
        let aStr = aText.trimmingCharacters(in: .whitespacesAndNewlines)
        let bStr = bText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let a = Double(aStr), let b = Double(bStr) else {
            return ""
        }

        switch selectedOp {
        case .add: return format(a + b)
        case .sub: return format(a - b)
        case .mul: return format(a * b)
        case .div:
            if b == 0 { return "Không chia được cho 0" }
            return format(a / b)
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Bài 2 - Tuần 2")
                .font(.headline)
                .padding(.top, 24)

            TextField("Nhập số thứ nhất", text: $aText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            HStack(spacing: 16) {
                ForEach(Op.allCases, id: \.self) { op in
                    Button(action: { selectedOp = op }) {
                        Text(op.rawValue)
                            .font(.headline)
                            .frame(width: 56, height: 56)
                            .foregroundColor(.white)
                            .background(buttonColor(for: op))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedOp == op ? Color.black : Color.clear, lineWidth: 2)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 4)

            TextField("Nhập số thứ hai", text: $bText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .padding(.horizontal)

            HStack {
                Text("Kết quả:")
                Text(resultText.isEmpty ? "" : resultText)
                    .fontWeight(.semibold)
            }
            .padding(.top, 8)

            Spacer()
        }
        .onTapGesture { hideKeyboard() }
    }

    private func buttonColor(for op: Op) -> Color {
        switch op {
        case .add: return .red
        case .sub: return .orange
        case .mul: return .purple
        case .div: return .black
        }
    }

    private func format(_ x: Double) -> String {
        if x.rounded() == x { return String(Int(x)) }
        return String(x)
    }

    private func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
        #endif
    }
}
