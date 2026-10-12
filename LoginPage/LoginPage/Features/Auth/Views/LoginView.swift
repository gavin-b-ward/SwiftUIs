//
//  LoginView.swift
//  LoginPage
//
//  Created by gavin ward on 10/8/26.
//

import AuthenticationServices
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct LoginView: View {
    @EnvironmentObject private var auth: AuthService

    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var isSubmitting = false

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                loginForm
                    .padding(.horizontal, 32)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                logoPlaceholder
                    .position(x: proxy.size.width / 2, y: 100)
                    .allowsHitTesting(false)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .background(Color(.systemGroupedBackground))
        }
    }

    private var loginForm: some View {
        VStack(spacing: 20) {
            Text(isRegistering ? "Register" : "Login")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.primary)

            TextField("Enter your email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .padding()
                .background(
                    Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 20)
                )

            SecureField("Enter your password", text: $password)
                .textContentType(isRegistering ? .newPassword : .password)
                .padding()
                .background(
                    Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 20)
                )

            if let error = auth.authError {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }

            Button {
                submitEmailPassword()
            } label: {
                if isSubmitting {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(isRegistering ? "Create account" : "Login")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(isSubmitting || email.isEmpty || password.isEmpty || !auth.isConfigured)

            Button(isRegistering ? "Already have an account? Login" : "Need an account? Register") {
                auth.authError = nil
                isRegistering.toggle()
            }
            .font(.subheadline)
            .disabled(isSubmitting)

            socialSignInDivider

            socialSignInButtons
        }
    }

    private var logoPlaceholder: some View {
        Image(systemName: "photo")
            .font(.system(size: 36, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: 96, height: 96)
            .background(
                Color(.secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 24)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }

    private var socialSignInDivider: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(height: 1)

            Text("OR")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(height: 1)
        }
        .padding(.horizontal, 32)
    }

    private var socialSignInButtons: some View {
        HStack(spacing: 12) {
            SignInWithAppleButton(
                .signIn,
                onRequest: { _ in
                    auth.authError = "Apple sign-in is just a placeholder in this demo."
                },
                onCompletion: { _ in }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button(action: signInWithGoogle) {
                HStack(spacing: 8) {
                    Image("googleLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)

                    Text("Google")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
            .disabled(!auth.isConfigured)
        }
    }

    private func submitEmailPassword() {
        isSubmitting = true
        Task {
            if isRegistering {
                await auth.register(email: email, password: password)
            } else {
                await auth.signIn(email: email, password: password)
            }
            isSubmitting = false
        }
    }

    private func signInWithGoogle() {
#if canImport(UIKit)
        guard let viewController = UIApplication.shared.firstKeyWindow?.rootViewController else {
            auth.authError = "Could not find a window to present Google Sign-In."
            return
        }

        Task { await auth.signInWithGoogle(presenting: viewController) }
#else
        auth.authError = "Google Sign-In is only wired for iOS in this demo."
#endif
    }
}

#if canImport(UIKit)
private extension UIApplication {
    var firstKeyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }
    }
}
#endif

#Preview {
    LoginView()
        .environmentObject(AuthService())
}
