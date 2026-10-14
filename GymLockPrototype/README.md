# GymLockPrototype

Throwaway native iOS proof of concept for GymLock's Screen Time APIs.

## Run

1. Open `GymLockPrototype.xcodeproj` in Xcode.
2. Select the `GymLockPrototype` target and your development team.
3. In Signing & Capabilities, verify **Family Controls** is enabled.
4. Build/run on a physical iPhone.

This will not be meaningfully testable in the simulator. Family Controls requires the Apple entitlement `com.apple.developer.family-controls`; provisioning may fail unless the selected Apple Developer team/profile has access to that restricted entitlement.

## Prototype scope

Implemented:

- Individual Screen Time authorization request.
- Apple's `FamilyActivityPicker` for selecting apps, websites, and categories.
- Manual block/unblock/re-block via `ManagedSettingsStore` shields.
- Basic diagnostics and lifecycle messages.
- Selection persistence using `FamilyActivitySelection` encoding in `UserDefaults`.

Not implemented:

- `DeviceActivity` schedules or monitor extension.
- Custom shield UI/action extensions.
- Production architecture, persistence, tests, styling, auth, backend, gym logic.

See `FINDINGS.md` and `MANUAL_TEST_CHECKLIST.md` before testing.
