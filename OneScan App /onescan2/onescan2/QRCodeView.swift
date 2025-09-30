import SwiftUI
import UIKit

struct QRCodeView: View {
    @State private var urlInput: String = ""
    @State private var warningMessage: String = "Nothing Generated!"
    @State private var showMenuOverlay = false
    @State private var navigateToPrivacy = false
    @State private var navigateToGuide = false
    @State private var navigateToDeveloper = false
    @State private var qrCodeURL: URL? = nil
    @State private var isLoading = false
    @State private var qrCodeImage: UIImage? = nil
    @State private var showShareSheet = false

    let backendBaseURL = "https://qr-code-project-verison-2.onrender.com"
    let appShareLink = "https://code-tech77.github.io/OneScan-Website/index.html"

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 142/255, green: 141/255, blue: 131/255)
                    .ignoresSafeArea()

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

                        Button {
                            showShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showShareSheet) {
                            ActivityView(activityItems: [URL(string: appShareLink)!])
                        }
                    }
                    .padding(.horizontal)

                    Text("One Scan - One Time QR Code Scan")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    // Input
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Enter Here:")
                            .font(.headline)
                            .foregroundColor(.black)

                        TextField("Enter HTTPS URL...", text: $urlInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        VStack(alignment: .leading, spacing: 5) {
                            Label("Use HTTPS, not HTTP", systemImage: "exclamationmark.triangle.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Label("Enter a valid URL", systemImage: "exclamationmark.triangle.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.horizontal)

                    // QR Code Display
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .frame(height: 240)

                        if let qrURL = qrCodeURL {
                            AsyncImage(url: qrURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .interpolation(.none)
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .onAppear {
                                            loadUIImage(from: qrURL)
                                        }
                                case .failure:
                                    Text("Failed to load image.")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Text(warningMessage)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)

                    // Generate Button
                    Button(action: generateQRCode) {
                        if isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Generate QR Code")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(color: Color.yellow.opacity(0.5), radius: 8)
                    .padding(.horizontal)

                    // Save Button
                    if qrCodeImage != nil {
                        Button(action: saveToGallery) {
                            Text("Save in Gallery")
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

                    Spacer()

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

                // Overlay
                if showMenuOverlay {
                    Color.black.opacity(0.9)
                        .ignoresSafeArea()
                        .onTapGesture { withAnimation { showMenuOverlay = false } }

                    VStack(spacing: 25) {
                        Button("Privacy Policies") {
                            withAnimation {
                                navigateToPrivacy = true
                                showMenuOverlay = false
                            }
                        }

                        Button("User Guide") {
                            withAnimation {
                                navigateToGuide = true
                                showMenuOverlay = false
                            }
                        }

                        Button("Who is the Developer") {
                            withAnimation {
                                navigateToDeveloper = true
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
                NavigationLink("", destination: PrivacyView(), isActive: $navigateToPrivacy)
                NavigationLink("", destination: GuideView(), isActive: $navigateToGuide)
                NavigationLink("", destination: DeveloperView(), isActive: $navigateToDeveloper)
            }
        }
    }

    // MARK: - Generate QR
    func generateQRCode() {
        let trimmed = urlInput.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: trimmed), UIApplication.shared.canOpenURL(url),
              trimmed.lowercased().hasPrefix("https") else {
            qrCodeURL = nil
            qrCodeImage = nil
            warningMessage = "⚠️ Please enter a valid HTTPS URL"
            return
        }

        guard let requestURL = URL(string: "\(backendBaseURL)/generate_qr") else {
            warningMessage = "Server URL is not valid"
            return
        }

        isLoading = true
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "text=\(trimmed)".data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { isLoading = false }

            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let qrPath = json["qr_path"] as? String else {
                DispatchQueue.main.async {
                    warningMessage = "❌ Failed to get QR code from server."
                }
                return
            }

            let qrURLString = backendBaseURL + qrPath
            if let qrURL = URL(string: qrURLString) {
                DispatchQueue.main.async {
                    qrCodeURL = qrURL
                    warningMessage = ""
                }
            }
        }.resume()
    }

    // MARK: - Load UIImage
    func loadUIImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    qrCodeImage = uiImage
                }
            }
        }.resume()
    }

    // MARK: - Save to Gallery
    func saveToGallery() {
        guard let image = qrCodeImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        warningMessage = "✅ Saved to gallery!"
    }
}

// MARK: - ActivityView for sharing
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
