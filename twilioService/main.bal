import ballerina/http;
import ballerina/log;
import ballerinax/twilio;

# Configuration parameters for the Twilio account.
configurable string accountSId = ?;
configurable string authToken = ?;
configurable string fromMobile = ?;

# Twilio connection configuration using the specified accountSId and authToken.
twilio:ConnectionConfig twilioConfig = {
    twilioAuth: {
        accountSId: accountSId,
        authToken: authToken
    }
};

# HTTP service to handle Twilio-related functionalities.
service /twilio on new http:Listener(6060) {

    # Resource function to handle incoming SMS messages.
    # This function sends an SMS using the Twilio client.
    #
    # + message - An HTTP payload containing the SMS message details.
    #
    # Returns an optional error if the SMS sending process fails.
    #
    # Example:
    # post /twilio/sms { "message": "Hello, World!" }
    resource function post sms(@http:Payload Message message) returns error? {
        //Twilio Client
        twilio:Client twilioClient = check new (twilioConfig);
        twilio:SmsResponse response = check twilioClient->sendSms(fromMobile, "+94774581440", message.message);

        log:printInfo("SMS_SID: " + response.sid.toString() + ", Body: " + response.body.toString());
    }
}


// import ballerina/log;
// import ballerinax/twilio;
// configurable string fromMobile = ?;
// // configurable string toMobile = ?;
// configurable string accountSId = ?;
// configurable string authToken = ?;
// // configurable string message = "Wso2-Test-SMS-Message";
// public function main() returns error? {
//     //Twilio client configuration
//     twilio:ConnectionConfig twilioConfig = {
//         twilioAuth: {
//         accountSId: accountSId,
//         authToken: authToken
//     }
//     };
//     //Twilio client
//     twilio:Client twilioClient = check new (twilioConfig);
//     //Get account detail remote function is called by the twilio client
//     var details = twilioClient->sendSms(fromMobile, toMobile, message);
//     //Response is printed as log messages
//     if (details is twilio:SmsResponse) {
//         log:printInfo("SMS_SID: " + details.sid.toString() + ", Body: " + details.body.toString());
//     } else {
//         log:printInfo(details.message());
//     }
// }
