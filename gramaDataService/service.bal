import ballerina/io;
import ballerina/sql;

function updateStatus(StatusEntry entry) returns string|error {
    sql:ParameterizedQuery query = `INSERT INTO "status" ("user_id", "id_check_status", "address_check_status", "police_check_status", "account_owner")
VALUES (${string:toUpperAscii(entry.nic)}, ${entry.idCheckStatus}, ${entry.addressCheckStatus}, ${entry.policeCheckStatus}, ${string:toUpperAscii(entry.accountOwner)});`;

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
    sql:ParameterizedQuery query = `SELECT * from "status" where LOWER(account_owner) = ${string:toLowerAscii(nic)};`;

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
    sql:ParameterizedQuery query = `SELECT * from "user" where LOWER(id) = ${string:toLowerAscii(nic)};`;

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
    sql:ParameterizedQuery query = `SELECT u.name, u.address, u.id as nicNumber, s.id as certificateNo, s.id_check_status, s.address_check_status, s.police_check_status FROM "user" u JOIN "status" s ON u.id = s.user_id WHERE LOWER(u.gramadevision) = ${string:toLowerAscii(gramaDevision)};`;

    stream<StatusDetails, sql:Error?> result = check dbQueryUser(query);
    io:println("result: ", result);

    json[] statusDetails = [];

    check from StatusDetails ent in result
        do {
            statusDetails.push(ent);
        };

    return statusDetails;
}

// SELECT u.name, u.address, u.id as user_id, s.id as status_id, s.id_check_status, s.address_check_status, s.police_check_status FROM "user" u JOIN "status" s ON u.id = s.user_id WHERE LOWER(u.gramadevision) = LOWER('Wellawatta');
