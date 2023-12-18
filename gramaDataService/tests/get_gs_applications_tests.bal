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
        "gramadevision": "Kollupitiya"
    };
    http:Response response = check testClient->post("/getGSApplication", payload);
    test:assertEquals(response.statusCode, 200);
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

@test:AfterGroups { value:["get_gs_application"] }
function after_get_gs_application_test() {
    io:println("Completed the get GS applications tests");
}