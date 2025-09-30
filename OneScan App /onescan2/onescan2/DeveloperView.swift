import SwiftUI

struct DeveloperView: View {
    @State private var showMenuOverlay = false
    @State private var goToHome = false
    @State private var goToPrivacy = false
    @State private var goToGuide = false

    let appLink = URL(string: "https://code-tech77.github.io/OneScan-Website/index.html")!

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 142/255, green: 141/255, blue: 131/255)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Header
                    HStack {
                        Button(action: {
                            withAnimation {
                                showMenuOverlay.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(.black)
                        }

                        Spacer()

                        ShareLink(item: appLink, subject: Text("Check out OneScan!")) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)

                    // Title
                    Text("Who is the Developer")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 10)

                    // Developer Image
                    Image("developer logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)

                    // Description
                    ScrollView {
                        Text(developerText)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                    }

                    // Support Button
                    Link(destination: URL(string: "https://www.buymeacoffee.com/onescan")!) {
                        Text("Support Talent Project")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .shadow(color: Color.yellow.opacity(0.6), radius: 5)
                    }
                    .padding(.horizontal)

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
                            withAnimation {
                                showMenuOverlay = false
                            }
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

                        Button("User Guide") {
                            withAnimation {
                                goToGuide = true
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
                NavigationLink(destination: GuideView(), isActive: $goToGuide) { EmptyView() }
            }
        }
    }

    var developerText: String {
        """
        I’ve always been someone who loves trying new things and pushing myself outside my comfort zone whether it’s learning a new language, picking up a new tool, or solving a problem just because it should be solvable. That mindset is what led me to build OneScan. The idea came to me during a college event where QR codes were used for attendance. I noticed how easy it was for people to just share the code with others, and it hit me: What if a QR code could only be scanned once?

        OneScan became my way of exploring both development and security in a hands on way. I built it using HTML, CSS, JavaScript, and Python, designing a system that invalidates each QR code after its first scan. It was my first time dealing with things like real time validation and dynamic code expiration, and I loved every frustrating, rewarding moment of it. It’s now something I’m really proud of not just because it works, but because I built it from an idea that sparked from real life.

        For me, tech isn’t just about code it’s about creativity, curiosity, and constantly learning. I’m on a journey to become a Cloud Security Architect, and projects like OneScan are my way of growing toward that goal. I’m always looking for new ways to challenge myself, explore new ideas, and build things that actually make a difference.
        """
    }
}
