//
//  LoginView.swift
//  LoginPage
//
//  Created by gavin ward on 10/8/26.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Login")
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
                    .textContentType(.password)
                    .padding()
                    .background(
                        Color(.secondarySystemGroupedBackground),
                        in: RoundedRectangle(cornerRadius: 20)
                    )

                socialSignInDivider

                socialSignInButtons
            }
            .padding(.horizontal, 32)

            VStack {
                logoPlaceholder
                    .padding(.top, 96)

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
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
                onRequest: { request in
                    // TODO: Configure Apple login
                },
                onCompletion: { result in
                    // TODO: Handle Apple login
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button(action: {
                // TODO: Google login
            }) {
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
        }
    }
}

#Preview {
    LoginView()
}
