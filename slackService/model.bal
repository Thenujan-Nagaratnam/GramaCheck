import ballerina/http;
import ballerina/time;

# Represents detailed information about an error.
# This record type includes a timestamp, a message, and additional details.
#
# Example:
# ErrorDetails errorInfo = {timeStamp: time:utcNow(), message: "An error occurred", details: "Details about the error"};
type ErrorDetails record {|
    # + timeStamp - The timestamp when the error occurred in Coordinated Universal Time (UTC).
    time:Utc timeStamp;
    # + message - A descriptive message about the error.
    string message;
    # + details - Additional details or context about the error.
    string details;
|};

# Represents an error response for notifications.
# This record type includes an HTTP 400 Bad Request status and detailed error information.
#
# + http :BadRequest - HTTP status code indicating a bad request.
# + body - ErrorDetails record providing detailed error information.
#
# Example:
# NotificationError errorResponse = {body: {timeStamp: time:utcNow(), message: "Invalid request", details: "Request validation failed"}};
type NotificationError record {|
    *http:BadRequest;
    ErrorDetails body;
|};

# Represents an slack message with message content.
# This record type is used to structure the data for sending slack messages.
#
# + message - The content of the SMS message.
#
# Example:
# Message msg = {message: "Hello, World!"};
type Message record {
    string message;
    string nic;
};
