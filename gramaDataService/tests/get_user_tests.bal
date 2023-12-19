import ballerina/http;
import ballerina/test;
import ballerina/io;

@test:BeforeGroups { value:["get_user"] }
function before_get_user_test() {
    io:println("Starting the check status tests");
}

@test:Config { groups: ["get_user"] }
function testServiceWithValidNIC() returns error? {
    json payload = {"nic": "123456789V"};
    http:Response response = check testClient->post("/getUser", payload);
    test:assertEquals(response.statusCode, 200);
    json result = check response.getJsonPayload();
    json expected = {"result": {"name": "Alice", "id": "123456789V", "address": "123, Sample Street", "phone_no": "1234567890", "gramadevision": "Bambalapitiya"}};
    test:assertEquals(result, expected);
}

// Negative test case
@test:Config { groups: ["get_user"] }
function testServiceWithInvalidNIC() returns error? {
    json payload = {"nic": "123456789"};
    http:Response response = check testClient->post("/getUser", payload);
    test:assertEquals(response.statusCode, 200);
    json result = check response.getJsonPayload();
    json expected = {"status": "Error", "description": "Something went wrong! please try again after some time"};
    test:assertEquals(result, expected);
}

@test:AfterGroups { value:["get_user"] }
function after_get_user_test() {
    io:println("Completed the check status tests");
}