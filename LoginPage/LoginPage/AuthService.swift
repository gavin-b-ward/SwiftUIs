//
//  AuthService.swift
//  LoginPage
//
//  Firebase-backed authentication state for the demo app.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
#if canImport(UIKit)
import UIKit
#endif

@MainActor
final class AuthService: ObservableObject {
    @Published private(set) var user: User?
    @Published private(set) var isReady = false
    @Published private(set) var isConfigured = false
    @Published var authError: String?

    private var listenerHandle: AuthStateDidChangeListenerHandle?

    var isSignedIn: Bool { user != nil }
    var email: String { user?.email ?? "Unknown email" }
    var uid: String { user?.uid ?? "No uid" }

    func start() {
        guard !isReady else { return }
        isConfigured = FirebaseApp.app() != nil

        guard isConfigured else {
            isReady = true
            authError = "Firebase is not configured yet. Add GoogleService-Info.plist to the app target."
            return
        }

        listenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.user = user
                self?.isReady = true
            }
        }
    }

    func signIn(email: String, password: String) async {
        await runAuthAction {
            _ = try await Auth.auth().signIn(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password)
        }
    }

    func register(email: String, password: String) async {
        await runAuthAction {
            _ = try await Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password)
        }
    }

    func sendPasswordReset(email: String) async {
        await runAuthAction {
            try await Auth.auth().sendPasswordReset(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }

#if canImport(UIKit)
    func signInWithGoogle(presenting viewController: UIViewController) async {
        await runAuthAction {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                throw AuthDemoError.googleClientIDMissing
            }

            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)

            guard let idToken = result.user.idToken?.tokenString else {
                throw AuthDemoError.googleIDTokenMissing
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            _ = try await Auth.auth().signIn(with: credential)
        }
    }
#endif

    func signOut() {
        do {
            try Auth.auth().signOut()
            authError = nil
        } catch {
            authError = error.localizedDescription
        }
    }

    func idToken() async throws -> String {
        guard FirebaseApp.app() != nil else { throw AuthDemoError.firebaseNotConfigured }
        guard let user = Auth.auth().currentUser else { throw AuthDemoError.notSignedIn }
        return try await user.getIDToken()
    }

    private func runAuthAction(_ action: @escaping () async throws -> Void) async {
        guard FirebaseApp.app() != nil else {
            authError = AuthDemoError.firebaseNotConfigured.localizedDescription
            return
        }

        do {
            authError = nil
            try await action()
        } catch {
            authError = error.localizedDescription
        }
    }

    deinit {
        if let listenerHandle {
            Auth.auth().removeStateDidChangeListener(listenerHandle)
        }
    }
}

enum AuthDemoError: LocalizedError {
    case firebaseNotConfigured
    case notSignedIn
    case googleClientIDMissing
    case googleIDTokenMissing

    var errorDescription: String? {
        switch self {
        case .firebaseNotConfigured:
            "Firebase is not configured. Add GoogleService-Info.plist to the app target first."
        case .notSignedIn:
            "You must be signed in before calling the backend."
        case .googleClientIDMissing:
            "Google Sign-In is not configured in this Firebase plist. Enable Google as a Firebase Auth provider, add an iOS OAuth client, then download the updated GoogleService-Info.plist."
        case .googleIDTokenMissing:
            "Google did not return an ID token. Try signing in again."
        }
    }
}
