// THROWAWAY PROTOTYPE: Screen Time API proof of concept for GymLock.

import SwiftUI
import FamilyControls

struct ScreenTimeView: View {
    private let service = ScreenTimeService()

    @Environment(\.scenePhase) private var scenePhase
    @State private var selection: FamilyActivitySelection
    @State private var isPickerPresented = false
    @State private var isRequestingAuthorization = false
    @State private var restrictionsApplied = false
    @State private var lastLifecycleEvent = "launched"
    @State private var message = "Use on a physical iPhone with the Family Controls capability enabled."
    @State private var errorMessage: String?

    init() {
        let service = ScreenTimeService()
        _selection = State(initialValue: service.loadSelection())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("GymLock Screen Time Prototype")
                    .font(.title2)
                    .bold()

                Text("Throwaway native iOS proof of concept. Question: can GymLock authorize Screen Time access, select apps/sites, block, unblock, and re-block with official APIs?")
                    .font(.footnote)

                GroupBox("Authorization") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Status: \(service.authorizationStatus.displayName)")
                        Button(isRequestingAuthorization ? "Requesting…" : "Authorize Screen Time") {
                            Task { await requestAuthorization() }
                        }
                        .disabled(isRequestingAuthorization)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox("Selection") {
                    VStack(alignment: .leading, spacing: 8) {
                        Button("Select Apps, Websites, Categories") {
                            isPickerPresented = true
                        }
                        Text("Applications: \(selection.applicationTokens.count)")
                        Text("Categories: \(selection.categoryTokens.count)")
                        Text("Websites: \(selection.webDomainTokens.count)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox("Restrictions") {
                    VStack(alignment: .leading, spacing: 8) {
                        Button("Block Selected Items") {
                            blockSelectedItems()
                        }
                        .disabled(!hasSelection)

                        Button("Unblock Selected Items") {
                            unblockSelectedItems()
                        }

                        Button("Re-block Previous Selection") {
                            selection = service.loadSelection()
                            blockSelectedItems()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox("Diagnostics") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Last event: \(lastLifecycleEvent)")
                        Text(message)
                        ForEach(service.diagnosticLines(for: selection, restrictionsApplied: restrictionsApplied), id: \.self) { line in
                            Text(line)
                                .font(.caption.monospaced())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let errorMessage {
                    GroupBox("Error") {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
        }
        .familyActivityPicker(isPresented: $isPickerPresented, selection: $selection)
        .onChange(of: selection) { _, newSelection in
            persistSelection(newSelection)
        }
        .onChange(of: scenePhase) { _, newPhase in
            lastLifecycleEvent = "scene phase changed to \(String(describing: newPhase))"
            message = "If restrictions are active, leave GymLock and manually open a selected app/site to verify Apple's shield."
        }
    }

    private var hasSelection: Bool {
        !selection.applicationTokens.isEmpty || !selection.categoryTokens.isEmpty || !selection.webDomainTokens.isEmpty
    }

    private func requestAuthorization() async {
        isRequestingAuthorization = true
        errorMessage = nil
        defer { isRequestingAuthorization = false }

        do {
            try await service.requestIndividualAuthorization()
            message = "Authorization request completed. Current status: \(service.authorizationStatus.displayName)."
        } catch {
            errorMessage = "Authorization failed: \(error.localizedDescription)"
            message = "Authorization did not complete. Check entitlement/provisioning and Screen Time settings."
        }
    }

    private func blockSelectedItems() {
        errorMessage = nil
        guard hasSelection else {
            message = "Nothing selected. Open the picker first."
            return
        }

        do {
            try service.saveSelection(selection)
            service.applyRestrictions(for: selection)
            restrictionsApplied = true
            message = "Block applied. Now open a selected app or website outside GymLock to verify the system shield."
        } catch {
            errorMessage = "Could not persist selection before blocking: \(error.localizedDescription)"
        }
    }

    private func unblockSelectedItems() {
        errorMessage = nil
        service.removeRestrictions()
        restrictionsApplied = false
        message = "Restrictions removed. Now open the previously blocked app/site to verify access is restored."
    }

    private func persistSelection(_ newSelection: FamilyActivitySelection) {
        do {
            try service.saveSelection(newSelection)
            message = "Selection saved. Counts updated below."
        } catch {
            errorMessage = "Selection persistence failed: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ScreenTimeView()
}
