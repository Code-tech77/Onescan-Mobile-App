import SwiftUI
import UserNotifications

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.6

    var body: some View {
        ZStack {
            Color(red: 142 / 255, green: 141 / 255, blue: 131 / 255)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.0)) {
                            scale = 1.0
                        }
                    }

                Text("OneScan : One - Time QR Code")
                    .font(.headline)
                    .foregroundColor(.black)

                Spacer()

                HStack {
                    Image(systemName: "lock.shield")
                        .foregroundColor(.black)
                    Text("Fast, Secured, Protection !")
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                requestNotificationPermission()
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            WelcomeView()
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            DispatchQueue.main.async {
                isActive = true
            }
        }
    }
}
