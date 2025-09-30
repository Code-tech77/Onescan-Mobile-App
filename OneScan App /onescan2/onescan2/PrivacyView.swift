import SwiftUI

struct PrivacyView: View {
    @State private var showMenuOverlay = false
    @State private var selectedPage: String? = nil
    @State private var goToHome = false
    @State private var goToGuide = false
    @State private var goToDeveloper = false

    let appLink = URL(string: "https://code-tech77.github.io/OneScan-Website/index.html")!

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 142 / 255, green: 141 / 255, blue: 131 / 255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Button(action: {
                            withAnimation { showMenuOverlay.toggle() }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .foregroundColor(.black)
                        }

                        Spacer()

                        ShareLink(item: appLink) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)

                    // Title
                    Text("OneScan Application Privacy")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    // Scrollable Privacy Text
                    ScrollView {
                        Text(privacyText)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                    }

                    // Footer
                    VStack(spacing: 8) {
                        HStack(spacing: 20) {
                            Link(destination: URL(string: "https://www.linkedin.com/company/onescan-app/")!) {
                                Image("linkedin-brands-solid")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }

                            Link(destination: URL(string: "https://www.instagram.com/onescan.app/")!) {
                                Image("instagram")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.top)

                // Overlay Menu
                if showMenuOverlay {
                    Color.black.opacity(0.9)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { showMenuOverlay = false }
                        }

                    VStack(spacing: 25) {
                        Button("Home Page") {
                            withAnimation {
                                goToHome = true
                                showMenuOverlay = false
                            }
                        }

                        Button("User Guide") {
                            withAnimation {
                                goToGuide = true
                                showMenuOverlay = false
                            }
                        }

                        Button("Who is the Developer") {
                            withAnimation {
                                goToDeveloper = true
                                showMenuOverlay = false
                            }
                        }
                    }
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .shadow(color: Color.yellow.opacity(0.5), radius: 8)
                }

                // Navigation Links
                NavigationLink(destination: QRCodeView(), isActive: $goToHome) { EmptyView() }
                NavigationLink(destination: GuideView(), isActive: $goToGuide) { EmptyView() }
                NavigationLink(destination: DeveloperView(), isActive: $goToDeveloper) { EmptyView() }
            }
        }
    }

    var privacyText: String {
        """
        This Privacy Policy explains how OneScan (“we,” “us,” or “our”) collects, uses, discloses, and safeguards your information when you use our application (“App”) and related services. We are committed to protecting your personal data and your right to privacy. By using OneScan, you consent to the practices described in this Privacy Policy. If you do not agree with the terms of this policy, please do not access or use our application.
        
        We collect information that you voluntarily provide when registering, submitting a request, or using features such as QR code generation. This may include your name, email address, and other identifiers. Additionally, we may collect information automatically, such as your device type, IP address, operating system, browser type, time zone, and usage behavior when you interact with our App. This data helps us provide, maintain, and improve our services.
        
        The core functionality of OneScan involves generating QR codes that are scannable only once. To support this, we assign a unique identifier to each QR code and store its scan status. Once the QR code has been scanned successfully, it is marked as expired and becomes invalid for future scans. This ensures data protection and controlled one time access. Users may optionally enable logs to monitor scan status, though this data is deleted periodically or upon user request.
        
        We use your personal information solely to deliver our services, ensure QR code functionality, analyze usage patterns to improve app performance, provide customer support, and fulfill any legal obligations. We do not use your information for marketing or advertising purposes and do not sell your personal data to third parties.
        
        We may share your data with trusted third party service providers that support the operation of our app, such as cloud hosting platforms or analytics providers. These partners are bound by contractual obligations to maintain the confidentiality and security of your information. We may also disclose your data if required by law, regulation, or legal process, or to protect the rights, safety, or property of OneScan, our users, or others.
        Your information is stored only as long as necessary to fulfill the purposes outlined in this Privacy Policy.
        
        For instance, QR code data is retained until the code is scanned or manually deleted by the user. You may request that we delete your personal information at any time by contacting us directly, and we will comply unless we are legally obligated to retain it.
        
        We take appropriate technical and organizational measures to protect your information against unauthorized access, loss, or misuse. These include HTTPS encryption, hashed identifiers, and secure cloud storage. However, no system can be guaranteed to be 100% secure. You are responsible for maintaining the security of your own devices and account credentials.
        
        If you are located in the European Economic Area (EEA), the General Data Protection Regulation (GDPR) provides certain rights regarding your personal data. These include the right to access, correct, delete, restrict processing, or object to our use of your data. You also have the right to data portability and to lodge a complaint with a supervisory authority. We will comply with GDPR and similar local laws when applicable.
        OneScan is not intended for children under the age of 13, and we do not knowingly collect data from minors. If we become aware that we have collected data from a child, we will delete it promptly. Parents or guardians who believe their child has submitted data should contact us immediately.
        
        Our App may contain links to third party services or websites. We are not responsible for the privacy practices or content of such third parties. We encourage users to read the privacy policies of any third party sites they visit.
        
        We reserve the right to modify this Privacy Policy at any time. If we make significant changes, we will provide notice within the app or via email, depending on your contact preferences. Your continued use of OneScan after such changes constitutes your acceptance of the updated policy.
        
        If you have questions or concerns about this Privacy Policy or how we handle your information, you may contact us at:
        
        Email: onescanmobileapp@gmail.com

        
        Thank you for trusting OneScan with your information.

        """
    }
}
