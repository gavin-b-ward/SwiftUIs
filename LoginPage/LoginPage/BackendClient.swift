//
//  BackendClient.swift
//  LoginPage
//
//  Shows how to pass Firebase auth from the phone app to your API.
//

import Foundation

struct BackendClient {
    /// Replace this with your API URL when wiring up a real backend.
    var baseURL = URL(string: "https://example.com")!

    func loadPrivateProfile(idToken: String) async throws -> BackendDemoResponse {
        var request = URLRequest(url: baseURL.appending(path: "api/private/profile"))
        request.httpMethod = "GET"
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")

        // Demo mode: do not actually call example.com. Return enough detail to show
        // exactly what your app would send to a backend.
        if baseURL.host == "example.com" {
            return BackendDemoResponse(
                status: "Demo request prepared",
                url: request.url?.absoluteString ?? "",
                authorizationHeaderPreview: "Bearer \(String(idToken.prefix(24)))…"
            )
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(BackendDemoResponse.self, from: data)
    }
}

struct BackendDemoResponse: Codable {
    let status: String
    let url: String
    let authorizationHeaderPreview: String
}
