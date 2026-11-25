import SwiftUI
import AppIntents
import UserNotifications

@main
struct WhiteScreenApp: App {
    var body: some Scene {
        WindowGroup {
            Color.white
                .ignoresSafeArea()
                .onAppear {
                    // Requests notification permission the first time you open the app
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
                }
        }
    }
}

struct RunMyCodeIntent: AppIntent {
    static var title: LocalizedStringResource = "Run My Code"
    static var openAppWhenRun: Bool = false

    func perform() async throws -> some IntentResult {
        await myCustomCode()
        return .result()
    }
}

// ==========================================
// WRITE ALL YOUR CUSTOM CODE INSIDE HERE:
// ==========================================
func myCustomCode() async {
    
    // 1. Optional: Ping your Linux server over Wi-Fi / Tailscale
    if let url = URL(string: "http://100.x.x.x:8000/startup") {
        _ = try? await URLSession.shared.data(from: url)
    }
    
    // 2. Send a confirmation notification to your iPhone so you know it ran
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    content.title = "WhiteScreenApp Ran"
    content.body = "Executed silently at \(Date().formatted(date: .omitted, time: .standard))"
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
    try? await center.add(request)
    
}
