import ballerina/io;
import ballerina/http;

endpoint http:Client backendCliEP{
    url: "http://b.content.wso2.com"
};

function main (string... args){

    var backendResponse = backendCliEP->get("/sites/all/ballerina-day/sample.json");
    match backendResponse {

        http:Response response => {
            json responseJson = check response.getJsonPayload();
            io:println(responseJson);
        }
        error responseError => {
            io:println(responseError.message);
        }
    }
}