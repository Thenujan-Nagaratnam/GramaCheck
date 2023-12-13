// import ballerina/http;
// import ballerina/io;

// configurable string idApiClientID = ?;
// configurable string idApiClientSecret = ?;

// http:Client httpClient = check new ({auth: {clientId: idApiClientID, clientSecret: idApiClientSecret}});
// IsValid getChecknicResponse = checkgramacheck_id_apiEndpoint->getChecknic(reqNic);

// public function main() returns error? {
//     http:Client httpClient = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/gramacheckidentitycheck/endpoint-25416-e8a/v1.0");
//     io:println("http client created");
//     string response = check httpClient->post("/nicCheck",
//         {
//             id: "123456789V",
//             name: "foo",
//             phone_no: "123456795",
//             address: "area 51"
//         }
//     );
// }

// // import ballerina/http;
// // import ballerina/io;
// // public function main() {
// //     http:Client client = new;
// //     http:Request request = new;
// //     request.url = "API_ENDPOINT";
// //     request.method = http:POST;
// //     request.setHeader("Content-Type", "application/json");
// //     request.setPayload({"nic": "123456789V"});
// //     var response = client->send(request);
// //     io:println(response.getJsonPayload());
// // }
// // import ballerina/http;

// // // Types
// // type isValid record {
// //     boolean valid;
// //     string nic;
// // };

// // type NicCheckRequest record {
// //     string nic;
// // };

// // // NIC Validation Service Endpoint URL
// // string nicValidationServiceURL = "http://localhost:25416/nicCheck";

// // public function main() returns error? {
// //     // Example NIC to check
// //     string sampleNIC = "123456789V";

// //     // Create a NIC Check request payload
// //     NicCheckRequest nicCheckRequest = {nic: sampleNIC};

// //     // Call the NIC validation service
// //     isValid|http:Error response = check nicValidationServiceURL    post nicCheckRequest;

// //     // Handle the response
// //     if (response is isValid) {
// //         // Valid NIC
// //         io:println("NIC is valid!");
// //     } else {
// //         // Error occurred
// //         io:println("Error validating NIC: ", response);
// //     }

// //     // Exit gracefully
// //     checkpanic ?;
// // }

