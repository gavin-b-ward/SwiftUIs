// THROWAWAY PROTOTYPE: Screen Time API proof of concept for GymLock.
// This app intentionally keeps architecture minimal so native API behavior is easy to inspect.

import SwiftUI

@main
struct GymLockPrototypeApp: App {
    var body: some Scene {
        WindowGroup {
            ScreenTimeView()
        }
    }
}
