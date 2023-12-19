import ballerina/io;
import ballerina/sql;

# Insert the Status of the Certificate
# This is implemented for the Grama Niladhari to decide whether the certificate is approved or not
#
# + entry - The StatusEntry object which contains the status of the certificate
# + return - The status of the update operation
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

# Update the Status of the Certificate
# This is implemented for the Grama Niladhari to decide whether the certificate is approved or not
#
# + entry - The StatusEntry object which contains the status of the certificate
# + return - The status of the update operation
function updateStatusEntry(UpdateStatusEntry entry) returns string|error {
    sql:ParameterizedQuery query = `UPDATE "status" SET id_check_status = ${entry.idCheckStatus}, address_check_status = ${entry.addressCheckStatus}, police_check_status = ${entry.policeCheckStatus} WHERE id = ${entry.id};`;

    io:println("query : ", query);
    sql:ExecutionResult|error result = dbExecute(query);
    io:println("result: ", result);

    if (result is error) {
        return result;
    } else {
        if (result.affectedRowCount == 0) {
            return "No records found!";
        } else {
            return "Successfully updated!";
        }
    }

}

# Get the Status History of the Certificate Application
# This is implemented for the user to get the history of the certificate applications
#
# + nic - The NIC number of the user
# + return - The status of the certificate application
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

# Get the Profile Details of the User
#
# + nic - The NIC number of the user
# + return - The profile details of the user
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

# Get the Status of the applications in a Grama Devision
# This is implemented for the Grama Niladhari to get the status of the applications in a Grama Devision
#
# + gramaDevision - The Grama Devision of the user
# + return - The status of the applications in the Grama Devision
function getGramaDevisionUsers(string gramaDevision) returns json[]|error {
    sql:ParameterizedQuery query = `SELECT u.name, u.address, u.id as nicNumber, s.id as certificateNo, s.id_check_status, s.address_check_status, s.police_check_status FROM "user" u JOIN "status" s ON u.id = s.user_id WHERE LOWER(u.gramadevision) = ${string:toLowerAscii(gramaDevision)} ORDER BY certificateNo DESC;`;

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
