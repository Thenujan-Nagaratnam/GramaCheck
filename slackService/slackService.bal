import ballerina/http;
import ballerina/time;
import ballerinax/slack;

configurable string access_token = ?;

type ErrorDetails record {|
    time:Utc timeStamp;
    string message;
    string details;
|};

type NotificationError record {|
    *http:BadRequest;
    ErrorDetails body;
|};

slack:ConnectionConfig slackConfig = {
    //access token got from slack
    auth: {
        token: access_token
    }
};

//create a slack client
slack:Client slackClient = check new (slackConfig);

// service to send notifications
service / on new http:Listener(7070) {

    resource function post sendNotifications/[string message]() returns string|error|NotificationError {

        //make the message
        slack:Message messageParams = {
            channelName: "gramacheck-project",
            text: message
        };

        // Post a message to a channel.
        string|error postResponse = check slackClient->postMessage(messageParams);

        if postResponse is error {

            ErrorDetails errorSendMsg = {timeStamp: time:utcNow(), message: "there is an error whike sending the message", details: string `reason for notification = ${message}`};
            NotificationError notificationError = {
                body: errorSendMsg
            };
            return notificationError;

        }

        return "successfully sent the notification!";

    }
}

