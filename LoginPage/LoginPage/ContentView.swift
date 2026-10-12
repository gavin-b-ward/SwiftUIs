//
//  ContentView.swift
//  LoginPage
//
//  Created by gavin ward on 10/8/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var auth: AuthService

    var body: some View {
        Group {
            if !auth.isReady {
                ProgressView("Loading auth…")
            } else if auth.isSignedIn {
                ProtectedAppView()
            } else {
                LoginView()
            }
        }
        .animation(.default, value: auth.isReady)
        .animation(.default, value: auth.isSignedIn)
        .onAppear { auth.start() }
    }
}

struct ProtectedAppView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem { Label("Home", systemImage: "house") }

            BackendTokenPage()
                .tabItem { Label("Backend", systemImage: "server.rack") }

            AccountPage()
                .tabItem { Label("Account", systemImage: "person.circle") }
        }
    }
}

struct HomePage: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Gated pages") {
                    NavigationLink("Private dashboard") { PrivateDetailPage(title: "Private dashboard") }
                    NavigationLink("Billing settings") { PrivateDetailPage(title: "Billing settings") }
                    NavigationLink("Team workspace") { PrivateDetailPage(title: "Team workspace") }
                }
            }
            .navigationTitle("Protected App")
        }
    }
}

struct PrivateDetailPage: View {
    let title: String

    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: "checkmark.seal.fill",
            description: Text("Only signed-in users can reach this page.")
        )
        .navigationTitle(title)
    }
}

struct BackendTokenPage: View {
    @EnvironmentObject private var auth: AuthService
    @State private var result = "Tap the button to get a Firebase ID token and attach it as an Authorization header."
    @State private var isLoading = false

    private let backend = BackendClient()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Backend auth handoff")
                    .font(.title.bold())
                Text("Firebase issues a signed ID token. Your backend verifies that token with the Firebase Admin SDK before returning private data.")
                    .foregroundStyle(.secondary)

                Button {
                    callBackend()
                } label: {
                    Label(isLoading ? "Preparing request…" : "Call private endpoint", systemImage: "key.fill")
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)

                Text(result)
                    .font(.callout.monospaced())
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))

                Spacer()
            }
            .padding()
            .navigationTitle("Backend")
        }
    }

    private func callBackend() {
        isLoading = true
        Task {
            do {
                let token = try await auth.idToken()
                let response = try await backend.loadPrivateProfile(idToken: token)
                result = """
                \(response.status)
                URL: \(response.url)
                Header: \(response.authorizationHeaderPreview)
                """
            } catch {
                result = error.localizedDescription
            }
            isLoading = false
        }
    }
}

struct AccountPage: View {
    @EnvironmentObject private var auth: AuthService

    var body: some View {
        NavigationStack {
            List {
                Section("Signed in as") {
                    LabeledContent("Email", value: auth.email)
                    LabeledContent("Firebase UID", value: auth.uid)
                }

                Section {
                    Button("Sign out", role: .destructive) {
                        auth.signOut()
                    }
                }
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
}
