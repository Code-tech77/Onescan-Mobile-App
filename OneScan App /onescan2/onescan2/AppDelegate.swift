import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        scheduleWeeklyNotification()
        return true
    }

    func scheduleWeeklyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "OneScan Reminder"
        content.body = "Come here and create your secured QR Code within seconds"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.weekday = Calendar.current.component(.weekday, from: Date()) // Today
        dateComponents.hour = 10 // 10 AM

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "weekly_qr_reminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification scheduling error: \(error.localizedDescription)")
            }
        }
    }
}
