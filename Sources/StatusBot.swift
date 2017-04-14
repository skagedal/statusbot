
import Foundation
import SlackKit

private struct Status {
    let emoji: String
    let text: String
}

extension Status: Equatable {
    static func ==(_ lhs: Status, _ rhs: Status) -> Bool {
        return lhs.emoji == rhs.emoji && lhs.text == rhs.text
    }
}

private typealias UserName = String

class StatusBot {
    
    let client: SlackClient
    let channel: String
    
    private var lastStatus: [UserName: Status] = [:]
    
    init(token: String, channel: String) {
        self.channel = channel
        client = SlackClient(apiToken: token)
        client.slackEventsDelegate = self
    }

    fileprivate func statusUpdated(to status: Status, for name: UserName, on client: SlackClient) {
        if let previousStatus = lastStatus[name], previousStatus == status {
            return
        }
        
        lastStatus[name] = status
        
        let text = "\(name): \(status.emoji) \(status.text)"
        print(text)
        
        client.webAPI.sendMessage(channel: channel, text: text, success: { (ts, channel) in
            print("success sending \(String(describing: ts))")
        }, failure: { error in
            print("error sending message: \(error)")
        })
    }
}

extension StatusBot: SlackEventsDelegate {
    func userChanged(_ user: User, client: SlackClient) {
        guard let name = user.name,
            let profile = user.profile,
            let emoji = profile.statusEmoji,
            let text = profile.statusText else {
                return
        }

        let status = Status(emoji: emoji, text: text)
        statusUpdated(to: status, for: name, on: client)
    }
    
    func preferenceChanged(_ preference: String, value: Any?, client: SlackClient) { }
    func presenceChanged(_ user: User, presence: String, client: SlackClient) { }
    func manualPresenceChanged(_ user: User, presence: String, client: SlackClient) { }
    func botEvent(_ bot: Bot, client: SlackClient) { }
}
