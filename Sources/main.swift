import Foundation

let env = ProcessInfo.processInfo.environment

guard let token = env["STATUSBOT_SLACK_TOKEN"] else {
    print("Set environment variable STATUSBOT_SLACK_TOKEN")
    exit(1)
}

let statusbot = StatusBot(token: token,
                          channel: "test-your-bot-here")

print("Running Statusbot")
statusbot.client.connect()

