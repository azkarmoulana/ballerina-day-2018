import ballerina/io;
import ballerina/log;
import ballerina/http;

endpoint http:Client lsten {
    url: "http://b.content.wso2.com/"
};

endpoint http:Listener listener {
    port:9090
};

service<http:Service> hello bind listener {

    @http:ResourceConfig {
        path: "/"
    }
    sayHello (endpoint caller, http:Request req) {
        var queryParam = req.getQueryParams();
        int year = check <int>queryParam.year;


        http:Response res = new;
        var response = lsten->get("/sites/all/ballerina-day/sample.json"); 
        match response {
            http:Response redf => {
                json respJson = check redf.getJsonPayload();
                json filteredBooks = filterBooks(respJson, year);
                _ = caller -> respond(untaint respJson);
            }
            error responseError => {
                io:println(responseError.message);
            }
        }
        // res.setPayload("Hello world..!");

        // var x = caller->respond(res);
    }
}   
    

    function filterBooks(json bookStore, int yearParam) returns json {
      json filteredBooks;
      int index;
      foreach book in bookStore.store.books {
          match book.year {
              int year => {
                  if (year > yearParam) {
                      filteredBooks[index] = book;
                      index++;
                  }
              }
          
              any a => {
                  io:println("incorrect year", a);
                }       
          }
    }
         
      return filteredBooks;       
}