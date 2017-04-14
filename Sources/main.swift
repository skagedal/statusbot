import Foundation

let statusbot = StatusBot(token: Secret.token,
                          channel: "test-your-bot-here")

print("Running Statusbot")
RunLoop.main.run()
