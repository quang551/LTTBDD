import SwiftUI

protocol PaymentMethod {
    var id: String { get }
    var title: String { get }
    var icon: String { get }   // SF Symbol
}

struct PayPal: PaymentMethod {
    let id = "paypal"
    let title = "PayPal"
    let icon = "p.circle.fill"
}
struct GooglePay: PaymentMethod {
    let id = "gpay"
    let title = "GooglePay"
    let icon = "g.circle.fill"
}
struct ApplePay: PaymentMethod {
    let id = "applepay"
    let title = "ApplePay"
    let icon = "apple.logo"
}

struct Bai2_Week3_PaymentView: View {
    private let methods: [any PaymentMethod] = [PayPal(), GooglePay(), ApplePay()]

    @State private var selectedId: String? = nil
    @State private var showAlert = false

    private var selectedTitle: String {
        guard let selectedId else { return "" }
        return methods.first(where: { $0.id == selectedId })?.title ?? ""
    }

    var body: some View {
        VStack(spacing: 16) {
            // Header (giống slide: có icon xe + line)
            Image(systemName: "car.fill")
                .font(.system(size: 54))
                .padding(.top, 10)

            Divider()
                .padding(.horizontal, 30)

            Text("Chọn hình thức thanh toán")
                .font(.headline)

            VStack(spacing: 12) {
                ForEach(methods, id: \.id) { m in
                    paymentRow(m)
                }
            }
            .padding(.horizontal, 16)

            // ✅ UI cập nhật theo lựa chọn
            if selectedId != nil {
                Text("Bạn đã chọn: \(selectedTitle)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            } else {
                Text("Vui lòng chọn 1 phương thức để tiếp tục")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }

            Spacer()

            Button("Continue") {
                showAlert = true
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(selectedId == nil ? Color.gray.opacity(0.35) : Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, 16)
            .disabled(selectedId == nil)
            .alert("Thanh toán", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Bạn đã chọn: \(selectedTitle)")
            }

            Spacer().frame(height: 10)
        }
        .background(Color(white: 0.97).ignoresSafeArea())
    }

    private func paymentRow(_ m: any PaymentMethod) -> some View {
        let isSelected = (selectedId == m.id)

        return Button {
            // ✅ Tap là UI đổi ngay
            selectedId = m.id
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)

                Text(m.title)
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: m.icon)
                    .font(.title3)
                    .foregroundColor(.black)
            }
            .padding(14)
            .background(isSelected ? Color.blue.opacity(0.08) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }
}
