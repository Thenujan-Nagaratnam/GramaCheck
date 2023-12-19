import ballerina/io;
import ballerina/http;
import ballerina/test;

@test:BeforeGroups { value:["update_status"] }
function before_update_status_test() {
    io:println("Starting the update status tests");
}

// Test function
@test:Config { groups: ["update_status"] }
function testServiceForCrimeRecordNotFound() {
    json payload = { "nic": "123456789V", "policeCheckStatus": 3, "idCheckStatus": 2, "addressCheckStatus": 2, "accountOwner": "123456789V" };
    http:Response response = checkpanic testClient->post("/updateStatus", payload);
    test:assertEquals(response.statusCode, 201);
    json result = checkpanic response.getJsonPayload();
    json expected = {status: "Success", description: "Successfully updated!"};
    test:assertEquals(result, expected);
}   

@test:AfterGroups { value:["update_status"] }
function after_update_status_test() {
    io:println("Completed the update status tests");
}
