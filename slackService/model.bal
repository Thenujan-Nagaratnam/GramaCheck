import ballerina/http;
import ballerina/time;

type ErrorDetails record {|
    time:Utc timeStamp;
    string message;
    string details;
|};

type NotificationError record {|
    *http:BadRequest;
    ErrorDetails body;
|};
