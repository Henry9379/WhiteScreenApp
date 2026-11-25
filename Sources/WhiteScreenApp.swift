import SwiftUI
import AppIntents

@main
struct WhiteScreenApp: App {
    var body: some Scene {
        WindowGroup {
            Color.white
                .ignoresSafeArea()
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

// WRITE ALL YOUR CUSTOM CODE INSIDE HERE:
func myCustomCode() async {
    
    // Example: Ping your Linux server over Wi-Fi / Tailscale
    guard let url = URL(string: "http://100.x.x.x:8000/startup") else { return }
    _ = try? await URLSession.shared.data(from: url)
    
}
