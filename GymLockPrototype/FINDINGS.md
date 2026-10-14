# GymLock Screen Time API Prototype Findings

This is a throwaway native iOS prototype to answer one question: can GymLock use Apple's public Screen Time APIs to authorize, select apps/sites, block, unblock, and re-block selections?

## What is implemented

- `FamilyControls.AuthorizationCenter` requests **individual** Screen Time authorization.
- `FamilyActivityPicker` presents Apple's system picker for applications, websites, and categories.
- `ManagedSettingsStore` applies shields for selected applications, application categories, web domains, and web domain categories.
- `ManagedSettingsStore.clearAllSettings()` removes restrictions.
- The last `FamilyActivitySelection` is encoded with `JSONEncoder` and stored in `UserDefaults`, then reused for re-blocking after normal interactions or relaunch.
- `DeviceActivity` is imported/investigated only; no schedules or extensions are configured yet.

## Required capabilities and entitlements

The app includes `GymLockPrototype/GymLockPrototype.entitlements` with:

```xml
<key>com.apple.developer.family-controls</key>
<true/>
```

In Xcode, verify the target has the **Family Controls** capability enabled and that the provisioning profile contains the entitlement. Family Controls is a restricted Apple entitlement; a normal development team may not be able to sign/install this until Apple enables the entitlement for the team/profile.

## Operations requiring explicit user interaction

- Screen Time authorization must be granted by the user via Apple's authorization UI/settings.
- App, website, and category selection must happen via Apple's `FamilyActivityPicker`.
- The app cannot silently enumerate all installed apps or bypass Screen Time authorization.

## Persistence notes

- The prototype attempts to persist `FamilyActivitySelection` using `Codable` conformance and `UserDefaults`.
- Managed settings are applied through a named `ManagedSettingsStore`; this prototype exposes a session-local "applied" flag, but the source of truth is iOS behavior. Verify by opening shielded apps/sites.

## Lifecycle questions to test on device

Not yet verified on an iPhone by this agent. Use `MANUAL_TEST_CHECKLIST.md` to record:

- Whether shields remain active when GymLock backgrounds.
- Whether shields remain active after force-quitting GymLock.
- Whether saved selections decode after relaunch and can be re-blocked.
- What UI/status appears after Screen Time authorization is revoked in Settings.

## Likely next extensions for production behavior

Automatic scheduled blocking/re-blocking should use `DeviceActivity` with the required Device Activity Monitor extension and, if custom shield UI/actions are needed, Shield Configuration / Shield Action extensions. This prototype intentionally does not implement scheduled blocking because manual block/unblock/re-block is enough to answer the core API feasibility question.

## Platform limitations to remember

- Testing must be on a physical iPhone; Screen Time APIs are entitlement- and device-dependent.
- Public APIs apply system-managed shields; they do not provide a general-purpose app-kill or network-blocking mechanism.
- Background timers should not be treated as reliable enforcement. Use Apple's Screen Time extension points for scheduled/automatic behavior.
