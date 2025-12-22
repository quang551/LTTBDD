import SwiftUI

struct Bai1: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                }
                .padding(.horizontal, 18)
                .padding(.top, 20)

                Spacer()

                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)

                Text("Vũ Minh Quang")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.top, 10)

                Text("Biên Hoà, Đồng Nai")
                    .foregroundColor(.gray)
                    .font(.system(size: 18))

                Spacer()
            }
        }
    }
}

#Preview { Bai1() }
