import SwiftUI

struct GuideView: View {
    @State private var showMenuOverlay = false
    @State private var goToHome = false
    @State private var goToPrivacy = false
    @State private var goToDeveloper = false

    let appLink = "https://code-tech77.github.io/OneScan-Website/index.html"

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 142 / 255, green: 141 / 255, blue: 131 / 255).ignoresSafeArea()

                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Button {
                            withAnimation { showMenuOverlay.toggle() }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(.black)
                        }

                        Spacer()

                        ShareLink(item: URL(string: appLink)!) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)

                    // Title
                    Text("OneScan User Guide")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    // Scrollable content
                    ScrollView {
                        Text(userGuideText)
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

                        Button("Privacy Policy") {
                            withAnimation {
                                goToPrivacy = true
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
                NavigationLink(destination: PrivacyView(), isActive: $goToPrivacy) { EmptyView() }
                NavigationLink(destination: DeveloperView(), isActive: $goToDeveloper) { EmptyView() }
            }
        }
    }

    var userGuideText: String {
        """
        Welcome to OneScan, a secure and intelligent application designed to create single use QR codes for enhanced privacy and control. This guide aims to help you understand how to use OneScan effectively, from generating QR codes to managing your account and ensuring maximum security throughout your usage.
        
        To get started with OneScan, download the application from the official app store or access the web version from our website. Upon launching the application, you will be presented with the option to sign in or continue as a guest. While guest access allows for basic QR code generation, creating an account is recommended for users who wish to benefit from features such as QR code management, history logs, advanced security settings, and cloud based backups.
        
        Creating a QR code with OneScan is straightforward. From the main dashboard, select the option to create a new QR code. You will then be asked to enter the content you wish to encode, such as a URL, text, contact information, or other supported data types. After entering the desired content, you can choose additional settings, such as whether the QR code should be valid for a single use or allow multiple scans. By default, OneScan generates QR codes that expire after one successful scan, providing enhanced protection against unauthorized reuse or sharing. You may also configure an optional expiration time, add passcode protection, or enable scan tracking depending on your needs.
        
        Once your QR code is created, it will be displayed on the screen with options to download it as an image, share the link, or copy it to your clipboard. The QR code remains active until it is either scanned, expires based on the timer set, or is manually deleted. If the QR code is scanned and marked as used, it will become invalid immediately and will no longer redirect to the encoded content.
        
        Scanning a QR code generated by OneScan can be done using any standard QR reader, including the built in camera apps on most smartphones. When a single use QR code is scanned, our system verifies its validity in real time. If the scan is successful and the code has not expired or been used, the user is redirected to the encoded content. If the code has already been scanned or is no longer valid, a customizable message or fallback screen will be displayed indicating that the QR code is inactive.
        
        In the “My Codes” section of the application, registered users can view and manage all of their generated QR codes. This section displays each code’s status, scan count (if logging is enabled), and options to view, edit, archive, or delete them. Archived QR codes remain visible for record keeping purposes but can no longer be scanned or modified. This feature is particularly useful for users managing time sensitive or one time access links, ensuring they maintain control over every QR interaction.
        
        OneScan incorporates several security features to ensure your QR codes are not misused. Every QR code generated with the single use option is validated through our secure backend and immediately marked inactive after one successful scan. To further enhance control, you may set scan limits, apply passcodes, or define time based expiration conditions. Additionally, users can enable scan logging to monitor when and from where each code was accessed. All data transmission is encrypted, and no content is publicly exposed unless explicitly shared by the user.
        
        Registered users benefit from account level features, including data syncing across devices, access to previous QR codes, download logs, and scan analytics. You can also customize your QR codes with themes, add branding elements such as logos, and receive email notifications for scans. Account security is ensured using hashed password storage and optional multi factor authentication. These features are ideal for business users, educators, and individuals who require secure sharing of sensitive links or information.
        
        If you encounter issues with a QR code not scanning, we recommend checking whether the code has already been used, verifying your internet connection, or ensuring the image is not blurry or damaged. If the QR code was printed, try reprinting it with higher resolution. In case the problem persists, you can visit our help center or contact our support team for further assistance.
        
        OneScan also includes a “Help” section within the app, where users can find answers to frequently asked questions and troubleshooting tips. This includes guidance on what single use means, how to handle expired codes, preventing unauthorized sharing, and managing privacy settings. Our customer support team is available to assist with technical issues or provide personalized advice on advanced configurations.
        
        We value user feedback and are constantly working to improve the application. You are encouraged to use the “Send Feedback” option in the app to share your thoughts, suggest new features, or report any bugs you may encounter. Your input is essential in shaping future updates and enhancing the overall user experience.
        
        Thank you for choosing OneScan. We are proud to offer a secure, innovative, and reliable solution for generating single use QR codes. Whether you’re using OneScan for education, events, authentication, or secure document access, we aim to provide you with the tools you need to manage QR code interactions safely and efficiently.
        """
    }
}
