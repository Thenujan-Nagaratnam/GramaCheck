import ballerina/http;
import ballerina/io;
import ballerina/test;

@test:BeforeGroups { value:["get_gs_application"] }
function before_get_gs_application_test() {
    io:println("Starting the get GS applications tests");
}


@test:Config { groups: ["get_gs_application"] }
function testServicegetGramaDevisionWithValidPayload() returns error? {
    json payload = {
        "gramadevision": "2c"
    };
    http:Response response = check testClient->post("/getGSApplication", payload);
    test:assertEquals(response.statusCode, 200);
    json result = check response.getJsonPayload();
    json expected = {
        "result": [
            {
                "name": "Alice",
                "id": "123456789V",
                "address": "1",
                "phone_no": "1234567890",
                "gramadevision": "2C"
            }
        ]
    };

    test:assertEquals(result, expected);

}

@test:AfterGroups { value:["get_gs_application"] }
function after_get_gs_application_test() {
    io:println("Completed the get GS applications tests");
}