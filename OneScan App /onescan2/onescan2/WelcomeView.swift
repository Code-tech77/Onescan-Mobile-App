import SwiftUI
import UserNotifications

struct WelcomeView: View {
    @State private var isNavigating = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 142 / 255, green: 141 / 255, blue: 131 / 255)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 320)

                    Text("Welcome to OneScan")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Your secure one-time QR generator")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))

                    Spacer()

                    Button(action: requestNotificationPermission) {
                        Text("Continue")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .shadow(color: Color.yellow.opacity(0.5), radius: 8)
                    }
                    .padding(.horizontal)
                }
                .padding()

                NavigationLink(destination: QRCodeView(), isActive: $isNavigating) {
                    EmptyView()
                }
            }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isNavigating = true
            }
        }
    }
}
