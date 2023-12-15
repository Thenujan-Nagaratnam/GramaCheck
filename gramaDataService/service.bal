import ballerina/io;
import ballerina/sql;

function updateStatus(StatusEntry entry) returns string|error {
    sql:ParameterizedQuery query = `INSERT INTO "status" ("user_id", "id_check_status", "address_check_status", "police_check_status")
VALUES (${entry.nic}, ${entry.idCheckStatus}, ${entry.addressCheckStatus}, ${entry.policeCheckStatus});`;

    io:println("query : ", query);
    sql:ExecutionResult|error result = dbExecute(query);
    io:println("result: ", result);

    if (result is error) {
        return result;
    } else {
        return "Successfully updated!";
    }

}

function getStatusHistory(string nic) returns json[]|error {
    sql:ParameterizedQuery query = `SELECT * from "status" where "account_owner" = ${string:toLowerAscii(nic)} OR "account_owner" = ${string:toUpperAscii(nic)};`;

    stream<StatusRecord, sql:Error?> result = check dbQueryStatus(query);
    io:println("result: ", result);

    json[] statusRecords = [];

    check from StatusRecord ent in result
        do {
            statusRecords.push(ent);
        };

    return statusRecords;

}

function getUserDetails(string nic) returns UserDetails|error {
    sql:ParameterizedQuery query = `SELECT * from "user" where "id" = ${string:toLowerAscii(nic)} OR "id" = ${string:toUpperAscii(nic)};`;

    sql:ExecutionResult|error result = check dbQueryRow(query);

    //{"affectedRowCount":null,"lastInsertId":null,"phone_no":"1234567890","address":"123, Sample Street","name":"Alice","id":"123456789V"}
    if (result is error) {
        return result;
    } else {
        UserDetails userDetails = {
            id: result["id"].toString(),
            name: result["name"].toString(),
            address: result["address"].toString(),
            phone_no: result["phone_no"].toString(),
            gramadevision: result["gramadevision"].toString()
        };
        return userDetails;
    }
}

function getGramaDevisionUsers(string gramaDevision) returns json[]|error {
    sql:ParameterizedQuery query = `SELECT * from "user" where "gramadevision" = ${string:toLowerAscii(gramaDevision)} OR "gramadevision" = ${string:toUpperAscii(gramaDevision)};`;

    stream<UserDetails, sql:Error?> result = check dbQueryUser(query);
    io:println("result: ", result);

    json[] userDetails = [];

    check from UserDetails ent in result
        do {
            userDetails.push(ent);
        };

    return userDetails;
}
