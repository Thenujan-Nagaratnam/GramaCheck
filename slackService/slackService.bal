import ballerina/http;
import ballerina/time;
import ballerinax/slack;

# Configuration parameter for the Slack access token.
configurable string access_token = ?;

# Slack connection configuration using the specified access token.
slack:ConnectionConfig slackConfig = {
    auth: {
        token: access_token
    }
};

# Create a Slack client using the configured connection.
# This client is used for sending messages to Slack channels.
slack:Client slackClient = check new (slackConfig);

# HTTP service to handle notifications via Slack.
service / on new http:Listener(7070) {

    # Resource function to send notifications to a Slack channel.
    #
    # + message - The message content to be sent as a notification.
    #
    # Returns a string indicating successful notification or an error in case of failure.
    # In case of an error, a detailed error message is encapsulated in a NotificationError record.
    #
    # Example:
    # post /sendNotifications/{"Hello, World!"}
    resource function post sendNotifications/[string message]() returns string|error|NotificationError {

        //The message
        slack:Message messageToSend = {
            channelName: "gramacheck-project",
            text: message
        };

        // Post a message to a channel.
        string|error postResponse = check slackClient->postMessage(messageToSend);

        if postResponse is error {

            ErrorDetails errorMsg = {timeStamp: time:utcNow(), message: "there is an error whike sending the message", details: string `reason for notification = ${message}`};
            NotificationError notificationError = {
                body: errorMsg
            };
            return notificationError;

        }

        return "successfully sent the notification!";

    }
}

