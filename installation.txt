Before you start the PANDA SDL please ensure the following is complete:

1. OBS .env variables 
    If you want to use OBS to record your lab area. Please install OBS and establish
    a local webserver for PANDA_SDL to communicate with. Complete the OBS portion
    of the .env file with the applicable information. If you do not wish to use OBS
    then set the PANDA_SDL_USE_OBS variable to '0' (with quotation marks).

2. Slack .env variables
    If you want to use slack, you will need to research how to create
    a slackbot and invite it to your workspace. Once set up, PANDA SDL uses 3 channels
    for communication and 3 copies of those channels for testing. 
    
    CONVERSATION_CHANNEL_ID is for general conversation and rarely used by the bot,
    but is good to have the connection incase you want to have data sent into the chat_postMessage

    ALERT_CHANNEL_ID is the primary channel for the slack_bot. This is where most
    notifications go.

    DATA_CHANNEL_ID is where the results of experiments are shared.

    Please fill in the .env section accordingly.
    
    If you do not want slack notifications
    then set the PANDA_SDL_USE_SLACK variable to '0' (with the quotation marks). 

3. Protocol vs Experiment Generators
    PANDA_SDL defines the list of steps to perform an experiment as a protocol.
    Metadata about an experiment, including which protocol to follow, is defined
    in the experiment_generator. There is usually a one-to-one ratio of protocols to
    generators unless you update the protocol but the metadata stays the same.


4. Complete the .env file
    The .env file is where your specific vales such as file paths and api keys
    are stored. Please complete it for the program to operate correctly.

5. Install both conda environments and activate panda_sdl_311

6. Install the PyCapture2 and FlyCapture2 SDK from FLIR into the two conda envs:
	https://www.flir.com/products/flycapture-sdk/



