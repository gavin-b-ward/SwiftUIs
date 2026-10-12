# LoginPage Firebase Auth Demo

This app demonstrates a common phone-app auth shape:

- Firebase email/password login and registration
- Google Sign-In button wired to Firebase Auth
- App pages gated by auth state
- Sign out and account state
- Fetching a Firebase ID token and sending it to a backend as `Authorization: Bearer <token>`

## Firebase setup

1. Go to <https://console.firebase.google.com/> and create a project.
2. In the project, open **Build → Authentication → Get started**.
3. Open **Sign-in method** and enable **Email/Password**.
4. Optional Google login: enable **Google** in **Sign-in method**.
5. Open **Project settings → General → Your apps → Add app → iOS**.
6. Use this bundle identifier: `com.gavinward.LoginPage`.
7. Download `GoogleService-Info.plist`.
8. Drag `GoogleService-Info.plist` into the `LoginPage/` folder in Xcode and ensure the `LoginPage` target is checked.
9. For Google login, the plist must contain `CLIENT_ID` and `REVERSED_CLIENT_ID`. If it does not, enable the Google auth provider and download the plist again.
10. Add the `REVERSED_CLIENT_ID` as a URL Scheme in Xcode: target **LoginPage → Info → URL Types → + → URL Schemes**.
11. Build and run. Register a new email/password account or tap Google.

The app intentionally does not crash if `GoogleService-Info.plist` is missing; the login screen shows a configuration message until you add it.

## Backend handoff

`BackendClient.swift` shows the mobile-to-backend contract:

```http
GET /api/private/profile
Authorization: Bearer <firebase-id-token>
```

On your backend, verify that ID token with the Firebase Admin SDK, then trust the decoded `uid`, `email`, and claims. Replace `https://example.com` in `BackendClient` with your API URL when ready.
