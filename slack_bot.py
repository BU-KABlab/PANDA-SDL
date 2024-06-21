"""Script to starting and stopping the ePANDA Slack Bot"""

import time
from panda_lib.slack_tools.SlackBot import SlackBot
choose_testing_mode = input("Enter 't' for testing mode or 'n' for non-testing mode: ").strip().lower()
if choose_testing_mode == "t":
    test = True
else:
    test = False
bot = SlackBot(test=test)
print("Starting Slack Bot")
STATUS = bot.check_slack_messages(channel="alert")
while STATUS == 1:
    try:
        time.sleep(5)
        STATUS = bot.check_slack_messages(channel="alert")
        bot.check_slack_messages(channel="data")
    except KeyboardInterrupt:
        break
    except Exception as e:
        print(e)
        time.sleep(15)
        continue

print("Stopping Slack Bot")
