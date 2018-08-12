import ballerina/io;

function main (string... args){
    
    string path = "sample.json";

    io:ByteChannel bytechannel = io:openFile(path, io:READ);
    io:CharacterChannel ch = new io:CharacterChannel(bytechannel, "UTF8");

    json|error result = ch.readJson();

    json bookStore;
    match result {
        json j =>{
            bookStore = j;
        }
        error =>{
            io:println("Error in reading the file", e.message);
            return;
        }
    }
    // io:println(bookStore);
    // io:println(bookStore["store"]["name"]);
    // io:println(bookStore["store"]["city"]);
    // io:println(bookStore["store"]["country"]);
    // io:println(bookStore.store.books.title[0]);
    // io:println(bookStore["store"]["books"]["author"]);
    // io:println(bookStore["store"]["books"]["language"]);
    // io:println(bookStore["store"]["books"]["year"]);


    foreach book in bookStore.store.books {
        match book.year {
        int year => {
                if (year > 1900){
                    io:println("Book name is : ",book.title);
                    io:println("Book author is : ",book.author);
                    io:println("Book language is : ",book.language);
                    io:println("Bokk year is : ",book.year);
                    io:println("\n");

                }
            }
        
        any => {
            io:println("incorrect year");
        }
    }
}
}
