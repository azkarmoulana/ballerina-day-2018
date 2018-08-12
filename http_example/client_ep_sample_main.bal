import ballerina/io;
import ballerina/http;

endpoint http:Client backendCliEP{
    url: "http://b.content.wso2.com";
};

function main (string... args){

    var backendResponse = backendClientEP->get("/sites/all/ballerina-day/sample.json");
    match backendResponse {

        http:Response response => {
            json responseJson = check response.getJsonPayLoad();
            io:println(response.json);
        }
        error responseError => {
            io:println(responseError.message);
        }
    }
}