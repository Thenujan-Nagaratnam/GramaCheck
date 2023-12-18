import ballerina/http;
import ballerina/io;
import ballerinax/postgresql.driver as _;

service / on new http:Listener(3000) {

    # Service for updating the Application Status of the user
    # This service will be called by the Grama Niladhari
    # 
    # + entry - StatusEntry object, which contains the information of the previous status
    # + caller - The caller of the service
    # + return - Error if any
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

    # Service for getting the status history of the user
    # This service will be called by the Citizens
    # 
    # + nic - NIC number of the user
    # + caller - The caller of the service
    # + return - Error if any
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

    # Service for getting the profile details of the user
    # This service will be called by the Citizens
    # 
    # + nic - NIC number of the user
    # + caller - The caller of the service
    # + return - Error if any
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

    # Service for getting all the applications for the given Grama Niladhari Division
    # This service will be called by the Grama Niladhari
    # 
    # + gramadevision - Grama Niladhari Division
    # + caller - The caller of the service
    # + return - Error if any
    resource function post getGSApplication(@http:Payload GramaDevision gramadevision, http:Caller caller) returns error? {
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
