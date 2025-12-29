import SwiftUI


enum ComponentSection: String, CaseIterable {
    case display = "Display"
    case input = "Input"
    case layout = "Layout"
    case basic = "More"
}

enum ComponentDestination {
    case text
    case images
    case textField
    case password
    case box
    case column
    case row
    case toggle
    case slider
    case stepper
    case progress
    case picker
}

struct UIComponentItem: Identifiable {
    let id = UUID()
    let section: ComponentSection
    let title: String
    let subtitle: String
    let destination: ComponentDestination
}


struct Week4_Bai1_RootView: View {
    var body: some View {
        NavigationStack {
            ReadyView()
        }
    }
}

private struct ReadyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "cube.transparent.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text("Jetpack Compose")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Jetpack Compose is a modern UI toolkit for\nbuilding native Android applications using\na declarative programming approach.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            Spacer()

            NavigationLink {
                ComponentsListView()
            } label: {
                Text("I’m ready")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 22)
            }

            Spacer().frame(height: 18)
        }
        .navigationTitle("I'm Ready")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(white: 0.97).ignoresSafeArea())
    }
}


private struct ComponentsListView: View {
    private let items: [UIComponentItem] = [
        .init(section: .display, title: "Text", subtitle: "Displays text", destination: .text),
        .init(section: .display, title: "Image", subtitle: "Displays an image", destination: .images),

        .init(section: .input, title: "TextField", subtitle: "Input field for text", destination: .textField),
        .init(section: .input, title: "PasswordField", subtitle: "Input field for passwords", destination: .password),

        .init(section: .layout, title: "Box", subtitle: "Overlays elements (ZStack)", destination: .box),
        .init(section: .layout, title: "Column", subtitle: "Arranges elements vertically", destination: .column),
        .init(section: .layout, title: "Row", subtitle: "Arranges elements horizontally", destination: .row),

        .init(section: .basic, title: "Toggle", subtitle: "On/Off switch", destination: .toggle),
        .init(section: .basic, title: "Slider", subtitle: "Choose a value", destination: .slider),
        .init(section: .basic, title: "Stepper", subtitle: "Increase / Decrease", destination: .stepper),
        .init(section: .basic, title: "Progress", subtitle: "Loading indicator", destination: .progress),
        .init(section: .basic, title: "Picker", subtitle: "Select an option", destination: .picker),
    ]

    var body: some View {
        List {
            ForEach(ComponentSection.allCases, id: \.self) { sec in
                let secItems = items.filter { $0.section == sec }
                if !secItems.isEmpty {
                    Section(sec.rawValue) {
                        ForEach(secItems) { item in
                            NavigationLink {
                                destinationView(for: item.destination)
                            } label: {
                                ComponentCardRow(title: item.title, subtitle: item.subtitle)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
            }

        }
        .listStyle(.plain)
        .navigationTitle("UI Components List")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(white: 0.97).ignoresSafeArea())
    }

    @ViewBuilder
    private func destinationView(for dest: ComponentDestination) -> some View {
        switch dest {
        case .text: TextDetailView()
        case .images: ImagesDetailView()
        case .textField: TextFieldDetailView()
        case .password: PasswordDetailView()
        case .box: BoxLayoutView()
        case .column: ColumnLayoutView()
        case .row: RowLayoutView()
        case .toggle: ToggleDetailView()
        case .slider: SliderDetailView()
        case .stepper: StepperDetailView()
        case .progress: ProgressDetailView()
        case .picker: PickerDetailView()
        }
    }
}

private struct ComponentCardRow: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.headline)
            Text(subtitle).font(.caption).foregroundColor(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.18))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


private struct TextDetailView: View {
    var body: some View {
        VStack {
            Spacer()
            (
                Text("The ") +
                Text("quick").strikethrough() +
                Text(" ") +
                Text("Brown").foregroundColor(.orange) +
                Text("\n") +
                Text("fox j u m p s ") +
                Text("over").fontWeight(.bold) +
                Text("\n") +
                Text("the").underline() +
                Text(" ") +
                Text("lazy").italic() +
                Text(" dog.")
            )
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)

            Spacer()
        }
        .navigationTitle("Text Detail")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}


private struct ImagesDetailView: View {
    private let url1 = URL(string: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200")!
    private let url2 = URL(string: "https://images.unsplash.com/photo-1526481280695-3c687fd5432c?w=1200")!

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: url1) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 14))

                Text(url1.absoluteString)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                AsyncImage(url: url2) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 14))

                Text("In app")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding(16)
        }
        .navigationTitle("Images")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}


private struct TextFieldDetailView: View {
    @State private var text = ""

    var body: some View {
        VStack(spacing: 14) {
            Spacer().frame(height: 18)

            TextField("Thông tin nhập", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 26)

            Text("Tự động cập nhật dữ liệu theo textfield")
                .font(.caption)
                .foregroundColor(.red)

            Text(text.isEmpty ? "" : "Bạn nhập: \(text)")
                .font(.footnote)
                .foregroundColor(.secondary)

            Spacer()
        }
        .navigationTitle("TextField")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}


private struct PasswordDetailView: View {
    @State private var pass = ""

    var body: some View {
        VStack(spacing: 14) {
            Spacer().frame(height: 18)

            SecureField("Mật khẩu", text: $pass)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 26)

            Text(pass.isEmpty ? "Nhập mật khẩu để tiếp tục" : "Đã nhập \(pass.count) ký tự")
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()
        }
        .navigationTitle("PasswordField")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}


private struct BoxLayoutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 16)

            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.blue.opacity(0.18))
                    .frame(height: 160)

                VStack(spacing: 8) {
                    Text("BOX (ZStack)")
                        .font(.headline)

                    Text("Nội dung nằm trên nền")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.blue.opacity(0.85))
                            .frame(width: 38, height: 38)
                        Circle()
                            .fill(Color.blue.opacity(0.35))
                            .frame(width: 38, height: 38)
                        Circle()
                            .fill(Color.blue.opacity(0.65))
                            .frame(width: 38, height: 38)
                    }
                    .padding(.top, 6)
                }
            }
            .padding(.horizontal, 16)

          
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.12))
                    .frame(height: 160)

                Text("Badge")
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(12)
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .navigationTitle("Box Layout")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct ColumnLayoutView: View {
    var body: some View {
        VStack(spacing: 14) {
            Spacer().frame(height: 10)

            VStack(spacing: 10) {
                DemoBox(text: "Item 1")
                DemoBox(text: "Item 2")
                DemoBox(text: "Item 3")
            }
            .padding(.horizontal, 16)

            Spacer()
        }
        .navigationTitle("Column Layout")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct RowLayoutView: View {
    private let cols: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: cols, spacing: 12) {
                ForEach(0..<12) { idx in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(idx % 3 == 1 ? Color.blue.opacity(0.85) : Color.blue.opacity(0.35))
                        .frame(height: 46)
                }
            }
            .padding(16)
        }
        .navigationTitle("Row Layout")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct DemoBox: View {
    let text: String
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.blue.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}


private struct ToggleDetailView: View {
    @State private var isOn = true
    var body: some View {
        Form {
            Toggle("Bật/Tắt", isOn: $isOn)
            Text(isOn ? "Đang bật" : "Đang tắt")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Toggle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SliderDetailView: View {
    @State private var value: Double = 30
    var body: some View {
        VStack(spacing: 16) {
            Slider(value: $value, in: 0...100)
                .padding(.horizontal, 18)
            Text("Giá trị: \(Int(value))")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.top, 18)
        .navigationTitle("Slider")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct StepperDetailView: View {
    @State private var count = 1
    var body: some View {
        VStack(spacing: 16) {
            Stepper("Số lượng: \(count)", value: $count, in: 1...20)
                .padding(.horizontal, 18)
            Spacer()
        }
        .padding(.top, 18)
        .navigationTitle("Stepper")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct ProgressDetailView: View {
    @State private var progress: Double = 0.4
    var body: some View {
        VStack(spacing: 16) {
            ProgressView(value: progress)
                .padding(.horizontal, 18)

            Button("Tăng tiến trình") {
                progress = min(1.0, progress + 0.1)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.top, 18)
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}

private struct PickerDetailView: View {
    @State private var choice = 0
    var body: some View {
        VStack(spacing: 16) {
            Picker("Chọn", selection: $choice) {
                Text("A").tag(0)
                Text("B").tag(1)
                Text("C").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 18)

            Text("Bạn chọn: \(["A","B","C"][choice])")
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding(.top, 18)
        .navigationTitle("Picker")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
    }
}


#Preview {
    Week4_Bai1_RootView()
        
}
