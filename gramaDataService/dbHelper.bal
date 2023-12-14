import ballerina/sql;
import ballerinax/postgresql;

configurable string host = ?;
configurable string username = ?;
configurable string db = ?;
configurable string password = ?;
configurable int port = ?;

function dbQueryRow(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->queryRow(query);

    check dbClient.close();

    return result;
};

function dbExecute(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->execute(query);

    check dbClient.close();

    return result;
};

function dbQueryStatus(sql:ParameterizedQuery query) returns stream<StatusRecord, sql:Error?>|error {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    stream<StatusRecord, sql:Error?> result = dbClient->query(query);

    check dbClient.close();

    return result;
};

function dbQueryUser(sql:ParameterizedQuery query) returns stream<UserDetails, sql:Error?>|error {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    stream<UserDetails, sql:Error?> result = dbClient->query(query);

    check dbClient.close();

    return result;
};
