"""Test that the slackbot is working correctly."""
from panda_lib.slack_tools import SlackBot

bot = SlackBot.SlackBot(True)
#bot.send_slack_message('alert',"Test message")

test_images = [
    "testing/test_image.png",
    "testing/test_image_2.png",
]

#bot.post_message_with_files("alert", "Test message with images", test_images)

# bot.upload_images("alert", test_images, "Test multiple file uploads :tada:")

bot.__share_experiment_images(10000877)
