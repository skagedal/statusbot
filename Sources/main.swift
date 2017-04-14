import Foundation
import SlackKit

class StatusBot {

    let client: SlackClient
    
    init(token: String) {
        client = SlackClient(apiToken: token)
        client.slackEventsDelegate = self
    }
}

extension StatusBot: SlackEventsDelegate {
    func userChanged(_ user: User, client: SlackClient) {
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
    
    func preferenceChanged(_ preference: String, value: Any?, client: SlackClient) {
    }
    
    func presenceChanged(_ user: User, presence: String, client: SlackClient) {
    }
    
    func manualPresenceChanged(_ user: User, presence: String, client: SlackClient) {
    }
    
    func botEvent(_ bot: Bot, client: SlackClient) {
    }
    
}


let statusbot = StatusBot(token: token)
statusbot.client.connect()
