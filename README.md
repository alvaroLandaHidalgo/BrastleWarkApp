# BrastleWarkApp

What modules i used?
I´m using SDWebImage Because with only one line allows you to display any picture with any kind of parameter. In my opinion is more comfortable than use the native way to display it. Sidelines, i use alamofire becausem the way to prepare the incoming data and parse it to JSON format is more cleary, is an Asynchronous way to http requests and if needed, NSURLCaché allows me to clear the catché.
Testing the app?
Well i add one test essentially, the only part that not depends only on the app, the part of parsing the get request to JSON data. Controlls if the data nil, in the case that the server is down. Here i added an error Handling too. Control every case the data can be recieved. If is nil, if the inhabitants is 0. 
