# GymLock Manual Test Checklist

Run on a physical iPhone with a provisioning profile containing the Family Controls entitlement.

## Setup

- [ ] Open `GymLockPrototype.xcodeproj` in Xcode.
- [ ] Select the `GymLockPrototype` target.
- [ ] Confirm Signing & Capabilities includes **Family Controls**.
- [ ] Confirm the selected team/profile can sign `com.apple.developer.family-controls`.
- [ ] Build and run on a physical iPhone.

## Authorization

- [ ] Launch GymLock.
- [ ] Confirm authorization status is displayed.
- [ ] Tap **Authorize Screen Time**.
- [ ] Grant access in Apple's UI.
- [ ] Confirm status changes to `approved`.
- [ ] If denied/fails, record exact error/status here:

Notes:

## Selection

- [ ] Tap **Select Apps, Websites, Categories**.
- [ ] Select Instagram or another installed app.
- [ ] Optionally select a website and a category.
- [ ] Dismiss picker.
- [ ] Confirm selected counts are non-zero.

Notes:

## Block

- [ ] Tap **Block Selected Items**.
- [ ] Leave GymLock.
- [ ] Open the selected app.
- [ ] Confirm Apple's Screen Time shield appears.
- [ ] Test selected website/category if chosen.

Notes:

## Unblock

- [ ] Return to GymLock.
- [ ] Tap **Unblock Selected Items**.
- [ ] Reopen the previously blocked app/site.
- [ ] Confirm it opens normally.

Notes:

## Re-block

- [ ] Return to GymLock.
- [ ] Tap **Re-block Previous Selection** or **Block Selected Items** again.
- [ ] Open the selected app/site.
- [ ] Confirm the shield appears again.
- [ ] Repeat block/unblock/re-block at least 3 times.

Notes:

## Lifecycle

- [ ] With restrictions active, background GymLock and open selected app/site.
- [ ] Record whether shield persists.
- [ ] Force-quit GymLock, then open selected app/site.
- [ ] Record whether shield persists.
- [ ] Relaunch GymLock.
- [ ] Confirm selection counts are restored.
- [ ] Tap **Unblock Selected Items** and verify access returns.
- [ ] Revoke Screen Time authorization in Settings.
- [ ] Relaunch GymLock and record displayed status/error behavior.

Notes:
