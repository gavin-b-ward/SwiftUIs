//
//  ContentView.swift
//  LoginPage
//
//  Created by gavin ward on 10/8/26.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var invalidCredentials: Bool = false
    @State private var showingLoginScreen: Bool = false
    
    var body: some View {
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
            HStack(spacing: 12) {
                // Apple Login
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

                // Google Login
            }
            HStack {
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
                }
            }
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }}

#Preview {
    ContentView()
}
