// import ballerinax/slack;

// configurable string access_token = ?;

// slack:ConnectionConfig slackConfig = {
//     auth: {
//         token: access_token
// }
// };

// slack:Client slackClient = check new (slackConfig);

// public function main() returns error? {
//     slack:Message messageParams = {
//         channelName: "gramacheck-project",
//         text: "Hello"
//     };

//     string threadTs = check slackClient->postMessage(messageParams);
// }
