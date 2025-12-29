import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var isBorrowed: Bool = false
    var borrowedBy: String? = nil
}

struct Staff: Identifiable {
    let id = UUID()
    var name: String
}

struct Bai3_Week3_LibraryView: View {
    @State private var staffName: String = "Nguyen Van A"

    @State private var books: [Book] = [
        Book(title: "Sách 01"),
        Book(title: "Sách 02"),
        Book(title: "Sách 03")
    ]

    @State private var staffs: [Staff] = [
        Staff(name: "Nguyen Van A"),
        Staff(name: "Tran Van B"),
        Staff(name: "Le Thi C")
    ]

    var body: some View {
        TabView {
            ManageTab(staffName: $staffName, books: $books)
                .tabItem { Label("Quản lý", systemImage: "house.fill") }

            BooksTab(books: $books)
                .tabItem { Label("DS Sách", systemImage: "books.vertical") }

            StaffTab(staffs: staffs)
                .tabItem { Label("Nhân viên", systemImage: "person.fill") }
        }
        .navigationTitle("Thư viện")
    }
}

private struct ManageTab: View {
    @Binding var staffName: String
    @Binding var books: [Book]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Hệ thống\nQuản lý Thư viện")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)

            Text("Nhân viên")
                .font(.headline)

            TextField("Tên nhân viên", text: $staffName)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled(true)

            Text("Danh sách sách (bấm để mượn/trả)")
                .font(.headline)
                .padding(.top, 6)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(books.indices, id: \.self) { i in
                        bookRow(i)
                    }
                }
                .padding(12)
                .background(Color.gray.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }

            Button("Thêm sách") {
                let next = books.count + 1
                books.append(Book(title: "Sách \(String(format: "%02d", next))"))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.top, 6)

            Spacer()
        }
        .padding(16)
    }

    private func bookRow(_ index: Int) -> some View {
        let b = books[index]
        return Button {
            if books[index].isBorrowed {
                books[index].isBorrowed = false
                books[index].borrowedBy = nil
            } else {
                books[index].isBorrowed = true
                books[index].borrowedBy = staffName
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: b.isBorrowed ? "checkmark.square.fill" : "square")
                    .foregroundColor(b.isBorrowed ? .red : .gray)

                VStack(alignment: .leading, spacing: 2) {
                    Text(b.title)
                        .foregroundColor(.black)

                    if let by = b.borrowedBy {
                        Text("Đang mượn bởi: \(by)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Trạng thái: Có sẵn")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
            }
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

private struct BooksTab: View {
    @Binding var books: [Book]

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { b in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(b.title)
                        if b.isBorrowed, let by = b.borrowedBy {
                            Text("Đang mượn bởi: \(by)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            Text("Trạng thái: Có sẵn")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Danh sách sách")
        }
    }
}

private struct StaffTab: View {
    let staffs: [Staff]
    

    var body: some View {
        NavigationStack {
            List(staffs) { s in
                Text(s.name)
            }
            .navigationTitle("Nhân viên")
        }
    }
}
