import ballerina/http;
import ballerina/io;
import ballerina/test;

http:Client testClient = check new ("http://localhost:3000");

// Before Suite Function

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("I'm the before suite function!");
}

// Test function

// Negative test function

@test:Config {}
function testServiceGetUser1() returns error? {
    json payload = {"nic": "123456789V"};
    http:Response response = check testClient->post("/getUser", payload);
    test:assertEquals(response.statusCode, 201);
    json result = check response.getJsonPayload();
    json expected = {"result": {"name": "Alice", "id": "123456789V", "address": "123, Sample Street", "phone_no": "1234567890", "gramadevision": "Bambalapitiya"}};
    test:assertEquals(result, expected);
}

@test:Config {}
function testServiceGetUser2() returns error? {
    json payload = {"nic": "123456789"};
    http:Response response = check testClient->post("/getUser", payload);
    test:assertEquals(response.statusCode, 500);
}

@test:Config {}
function testServicegetGramaDevisionUser1() returns error? {
    json payload = {
        "gramadevision": "Kollupitiya"
    };
    http:Response response = check testClient->post("/getGramaDevisionUser", payload);
    test:assertEquals(response.statusCode, 201);
    json result = check response.getJsonPayload();
    json expected = {
        "result": [
            {
                "name": "Bob",
                "id": "987654321V",
                "address": "456, Example Avenue",
                "phone_no": "9876543210",
                "gramadevision": "Kollupitiya"
            }
        ]
    };

    test:assertEquals(result, expected);

}

@test:AfterSuite {}
function functionafterSuiteFunc()
{
    io:println("I'm the after suite function!")
                                                                                                                                    ;
}
