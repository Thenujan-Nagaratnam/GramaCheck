import ballerina/http;
import ballerina/time;
import ballerinax/slack;

configurable string access_token = ?;

slack:ConnectionConfig slackConfig = {
    auth: {
        token: access_token
    }
};

//create a slack client
slack:Client slackClient = check new (slackConfig);

// service to send notifications
service / on new http:Listener(7070) {

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

