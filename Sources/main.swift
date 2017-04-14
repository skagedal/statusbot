import Foundation
import SlackKit

class StatusBot {

    let bot: SlackKit
    
    init(token: String) {
        bot = SlackKit(withAPIToken: token)
        bot.onClientInitalization = { client in
            DispatchQueue.main.async {
                client.slackEventsDelegate = self
            }
        }
    }
}

extension StatusBot: SlackEventsDelegate {
    func userChanged(_ user: User, client: Client) {
        let name = user.name ?? "<unknown>"
        let statusEmoji = user.profile?.statusEmoji ?? "<unknown>"
        let statusText = user.profile?.statusText ?? "<unknown>"

        let text = "\(name): \(statusEmoji) \(statusText)"
        
        client.webAPI.sendMessage(channel: "test-your-bot-here", text: text,
                                  success: { (ts, channel) in
                                    print("success sending \(String(describing: ts))")
        },
        failure: { error in
            print("error sending message: \(error)")
        })
    }
    
    func preferenceChanged(_ preference: String, value: Any?, client: Client) {
    }
    
    func presenceChanged(_ user: User, presence: String, client: Client) {
    }
    
    func manualPresenceChanged(_ user: User, presence: String, client: Client) {
    }
    
    func botEvent(_ bot: Bot, client: Client) {
    }
    
}

let statusbot = StatusBot(token: Secret.token)

print("Running Statusbot")
RunLoop.main.run()
