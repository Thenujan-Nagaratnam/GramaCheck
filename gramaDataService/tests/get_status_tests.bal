import ballerina/http;
import ballerina/io;
import ballerina/test;

@test:BeforeGroups {value: ["get_status"]}
function before_get_status_test() {
    io:println("Starting the get status tests");
}

@test:Config {groups: ["get_status"]}
function testServicegetStatus() returns error? {
    json payload = {
        "nic": "123456789V"
    };
    http:Response response = check testClient->post("/getStatus", payload);
    test:assertEquals(response.statusCode, 200);
    json result = check response.getJsonPayload();
    json expected = {
        "result": [
            {
                "id": 19,
                "user_id": "1234567890",
                "police_check_status": 2,
                "id_check_status": 0,
                "address_check_status": 1,
                "account_owner": "123456789V"
            },
            {
                "id": 1,
                "user_id": "123456789V",
                "police_check_status": 2,
                "id_check_status": 2,
                "address_check_status": 2,
                "account_owner": "123456789V"
            }
        ]
    };

    test:assertEquals(result, expected);

}

@test:AfterGroups {value: ["get_status"]}
function after_get_status_test() {
    io:println("Completed the get status tests");
}
