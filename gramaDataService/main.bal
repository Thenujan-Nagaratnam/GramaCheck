import ballerina/http;
import ballerina/io;
// import ballerina/sql;
import ballerinax/postgresql.driver as _;

public function main() {

}

service / on new http:Listener(3000) {

    resource function post updateStatus(@http:Payload StatusEntry entry, http:Caller caller) returns error? {
        http:Response response = new;
        string|error res = updateStatus(entry);

        if (res is error) {
            response.statusCode = 200;
            response.setPayload({status: "Error", description: "Something went wrong! please try again after some time"});
        } else {
            response.statusCode = 201;
            response.setPayload({status: "Success", description: res});
        }

        check caller->respond(response);

    }

    resource function post getStatus(@http:Payload Nic nic, http:Caller caller) returns error? {
        io:println("running: ", nic.nic);
        http:Response response = new;
        json[] result = check getStatusHistory(nic.nic);

        response.statusCode = 200;

        json respObj = {"result": result};

        response.setHeader("Content-Type", "application/json");
        response.setPayload(respObj);

        check caller->respond(response.getJsonPayload());
    }

    resource function post getUser(@http:Payload Nic nic, http:Caller caller) returns error? {
        io:println("running: ", nic.nic);
        http:Response response = new;
        UserDetails result = check getUserDetails(nic.nic);

        io:print("result: ", result);
        response.statusCode = 200;

        json respObj = {"result": result};

        response.setHeader("Content-Type", "application/json");
        response.setPayload(respObj);

        check caller->respond(response.getJsonPayload());
    }

    resource function post getGramaDevisionUser(@http:Payload GramaDevision gramadevision, http:Caller caller) returns error? {
        io:println("running: ", gramadevision.gramadevision);
        http:Response response = new;
        json[] result = check getGramaDevisionUsers(gramadevision.gramadevision);

        io:print("result: ", result);
        response.statusCode = 200;

        json respObj = {"result": result};

        response.setHeader("Content-Type", "application/json");
        response.setPayload(respObj);

        check caller->respond(response.getJsonPayload());
    }
}
