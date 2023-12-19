import ballerina/http;
import ballerina/io;

// configurable string idApiClientID = ?;
// configurable string idApiClientSecret = ?;

// http:Client httpClient = check new ({auth: {clientId: idApiClientID, clientSecret: idApiClientSecret}});

type User record {
    string nic;
    string name;
    string phone_no;
    string address;
};

// public function main() returns error? {
//     http:Client httpClient = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/gramacheckidentitycheck/endpoint-25416-e8a/v1.0/nicCheck");
//     // http:Client resourceClient = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/gramacheckidentitycheck/endpoint-25416-e8a/v1.0");
//     io:println("http client created");
//     http:Response response = check httpClient->post("", {id: "123456789V", name: "foo", phone_no: "123456795", address: "area 51"});
// }

service / on new http:Listener(9090) {

    resource function post sms(@http:Payload User user) returns error? {

        /////////////////////////////////////ID VALIDATION API/////////////////////////////////////

        http:Client gramacheck_id_apiEndpoint = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/gramacheckidentitycheck/endpoint-25416-e8a/v1.0/");

        http:Response response = check gramacheck_id_apiEndpoint->post("nicCheck", {nic: user.nic});

        io:print("response: ", response.getJsonPayload());

        // IsValid getChecknicResponse = check gramacheck_id_apiEndpoint->getChecknic(reqNic);

        /////////////////////////////////////ADDRESS VALIDATION API/////////////////////////////////////
        http:Client addresscheckEndpoint = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/address-check/endpoint-3000-197/v1.0/addressCheck");

        http:Response getCheckaddressResponse = check addresscheckEndpoint->post("", {nic: user.nic, address: user.address});

        io:print("response: ", getCheckaddressResponse);

        /////////////////////////////////////POLICE VALIDATION API/////////////////////////////////////
        http:Client police_check_api_pvEndpoint = check new ("https://cf3a4176-54c9-4547-bcd6-c6fe400ad0d8-dev.e1-us-east-azure.choreoapis.dev/gich/policecheckapi-pvm/police-check-df5/v1.0/check_status");

        http:Response getPersonCrimeRecordsResponse = check police_check_api_pvEndpoint->post("", {nic: user.nic});

        io:print("response: ", getPersonCrimeRecordsResponse);
    }
}
