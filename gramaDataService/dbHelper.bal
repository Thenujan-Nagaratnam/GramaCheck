import ballerina/sql;
import ballerinax/postgresql;

// configurable variables
configurable string host = ?;
configurable string username = ?;
configurable string db = ?;
configurable string password = ?;
configurable int port = ?;

# Executes the query, which is expected to return at most one row of the result.
# 
# + query - The query to execute.
# + return - The result of the query or error if any error occurred.
function dbQueryRow(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->queryRow(query);

    check dbClient.close();

    return result;
};

# Execute the query and only returns the metadata of the result.
# Used to execute INSERT
# 
# + query - The query to execute.
# + return - The result of the query or error if any error occurred.
function dbExecute(sql:ParameterizedQuery query) returns error|sql:ExecutionResult {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    sql:ExecutionResult|error result = dbClient->execute(query);

    check dbClient.close();

    return result;
};

# Find all the Status Records for the given query.
# 
# + query - The query to execute.
# + return - Stream of StatusRecord objects or error if any error occurred.
function dbQueryStatus(sql:ParameterizedQuery query) returns stream<StatusRecord, sql:Error?>|error {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    stream<StatusRecord, sql:Error?> result = dbClient->query(query);

    check dbClient.close();

    return result;
};

# Find all the Status Details for the given query.
# 
# + query - The query to execute.
# + return - Stream of StatusDetails objects or error if any error occurred.
function dbQueryUser(sql:ParameterizedQuery query) returns stream<StatusDetails, sql:Error?>|error {
    postgresql:Client dbClient = check new (host, username, password,
        db, port, connectionPool = {maxOpenConnections: 5}
    );

    stream<StatusDetails, sql:Error?> result = dbClient->query(query);

    check dbClient.close();

    return result;
};
