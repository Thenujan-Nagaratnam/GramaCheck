import ballerina/con
import ballerina/http;
import ballerina/log;
import ballerinax/twilio;

configurable string accountSId = ?;
configurable string authToken = ?;
configurable string fromMobile = ?;

type Message record {
    string fromMobile;
    string toMobile;
    string message;
};

twilio:ConnectionConfig twilioConfig = {
    twilioAuth: {
        accountSId: accountSId,
        authToken: authToken
    }
};

service /twilio on new http:Listener(6060) {

    resource function post sms(@http:Payload Message message) returns error? {
        //Twilio Client
        twilio:Client twilioClient = check new (twilioConfig);
        twilio:SmsResponse response = check twilioClient->sendSms(fromMobile, message.toMobile, message.message);

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
