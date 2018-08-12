import ballerina/http;
import marcus/gcontacts3;
import ballerina/io;
import wso2/gsheets4;


endpoint http:Listener listener {
    port:9090
};

endpoint gcontacts3:Client gContactsEP {
    clientConfig:{
        auth:{
            accessToken:"ya29.Glv3Ba683n9VjXW848jL_IYkk-jGBPZiP0rVJkvQdBTMGsWcI5roxtJTUwBloaHVI1DzMR5kC1ybTgoLgQpecD8jdU8QovsOcO9TOp5f98np0cEtJVbtfMRMXxEM",
            clientId:"179130405987-n4j91ps18n6pfi6npgpkarqle7qfvlk5.apps.googleusercontent.com",
            clientSecret:"JdF-C4SL-Pz2u7QWhhAIyrA6",
            refreshToken:"1/PFY0dqUR4L47lBjVP_y-8H74wMrE8wptE2wM-Qt5QG0"
        }
    }
};

endpoint gsheets4:Client spreadsheetEP {
    clientConfig:{
        auth:{
            accessToken:"ya29.Glv3BaYmX1kzA0AG1t_AhdCz8gE_DzUjm6kPTjy8ASlP1jYtpfPMFqQ64sOBbn0KVB3tnbC8ftrgBniQSisMLrJa8sBR7vySv8iRloIovYCAG0cr2fsIkkhrEZUY",
            clientId:"179130405987-n4j91ps18n6pfi6npgpkarqle7qfvlk5.apps.googleusercontent.com",
            clientSecret:"JdF-C4SL-Pz2u7QWhhAIyrA6",
            refreshToken:"1/PFY0dqUR4L47lBjVP_y-8H74wMrE8wptE2wM-Qt5QG0"
        }
    }
};


service<http:Service> hello bind listener {


    sayHello (endpoint caller, http:Request request) {

        string userEmail = "azkar.moulana@gmail.com";

    var response = gContactsEP -> getAllContacts(userEmail);

    match response {
        xml xmlRes => {
            io:println(xmlRes);
            _ = caller -> respond(untaint xmlRes);


            //spreadsheet data
            string  spreadsheetId = "1";
            string  sheetName = "myContacts";
            string  topLeftCell = "name";
            string  bottomRightCell = "email";
            //string[][]  values = "","";

            // sending data to a spreadsheet
            // var spreadresponse = spreadsheetEP->setSheetValues(spreadsheetId, sheetName, topLeftCell, bottomRightCell, values);
            // match response {
            // boolean isUpdated => io:println(isUpdated);
            // gsheets4:SpreadsheetError err => io:println(err);
//}


        }
        error err => {
            io:println(err);
        }
    }
    }
}