// THROWAWAY PROTOTYPE: Screen Time API proof of concept for GymLock.

import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

struct ScreenTimeService {
    private static let selectionDefaultsKey = "GymLockPrototype.familyActivitySelection"

    private let authorizationCenter = AuthorizationCenter.shared
    private let store = ManagedSettingsStore(named: ManagedSettingsStore.Name("GymLockPrototype"))

    var authorizationStatus: AuthorizationStatus {
        authorizationCenter.authorizationStatus
    }

    func requestIndividualAuthorization() async throws {
        try await authorizationCenter.requestAuthorization(for: .individual)
    }

    func applyRestrictions(for selection: FamilyActivitySelection) {
        store.shield.applications = selection.applicationTokens.isEmpty ? nil : selection.applicationTokens

        store.shield.applicationCategories = selection.categoryTokens.isEmpty
            ? nil
            : ShieldSettings.ActivityCategoryPolicy.specific(selection.categoryTokens)

        store.shield.webDomains = selection.webDomainTokens.isEmpty ? nil : selection.webDomainTokens

        // The FamilyActivityPicker exposes one category token set. Apply it to both app and web
        // category shielding so the prototype can reveal what iOS actually shields for a category.
        store.shield.webDomainCategories = selection.categoryTokens.isEmpty
            ? nil
            : ShieldSettings.ActivityCategoryPolicy.specific(selection.categoryTokens)
    }

    func removeRestrictions() {
        store.clearAllSettings()
    }

    func saveSelection(_ selection: FamilyActivitySelection) throws {
        let data = try JSONEncoder().encode(selection)
        UserDefaults.standard.set(data, forKey: Self.selectionDefaultsKey)
    }

    func loadSelection() -> FamilyActivitySelection {
        guard let data = UserDefaults.standard.data(forKey: Self.selectionDefaultsKey) else {
            return FamilyActivitySelection()
        }

        do {
            return try JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        } catch {
            return FamilyActivitySelection()
        }
    }

    func diagnosticLines(for selection: FamilyActivitySelection, restrictionsApplied: Bool) -> [String] {
        [
            "Authorization: \(authorizationStatus.displayName)",
            "Restrictions flag in this app session: \(restrictionsApplied ? "applied" : "not applied / unknown after relaunch")",
            "Selected applications: \(selection.applicationTokens.count)",
            "Selected categories: \(selection.categoryTokens.count)",
            "Selected web domains: \(selection.webDomainTokens.count)",
            "Selection persisted in UserDefaults: \(UserDefaults.standard.data(forKey: Self.selectionDefaultsKey) == nil ? "no" : "yes")",
            "DeviceActivity: imported for investigation; no schedules or extensions are configured in this prototype."
        ]
    }
}

extension AuthorizationStatus {
    var displayName: String {
        switch self {
        case .notDetermined:
            return "not determined"
        case .denied:
            return "denied"
        case .approved:
            return "approved"
        case .approvedWithDataAccess:
            return "approved with data access"
        @unknown default:
            return "unknown future status"
        }
    }
}
