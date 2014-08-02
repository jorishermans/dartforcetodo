dartforcetodo
=============

This is the code that I used in this video screencast http://youtu.be/FZr75CsBNag to show the working of dart force realtime power.

#### Textual tutorial ####

1) First create a project in the dart editor. File > New Project > Web Application

2) Create a bin folder in this project and put the file 'server.dart' into it!

3) This needs to be added into 'server.dart'

	library dart_force_todo;

	import "package:force/force_serverside.dart";
	
	void main() {
	  ForceServer fs = new ForceServer(clientFiles: "../build/web/", startPage: "dartforcetodo.html");
	  fs.setupConsoleLog();
	  fs.start();
	}

4) Now build your clientside code with Tools > Pub build (generates JS)

5) Wait until you have a build folder with the generated files in!

6) After all of this you are ready to test your code by right clicking on the 'server.dart' file, and push on the menu item 'Run'.

7) Then go to your browser and navigate to http://localhost:8080/ this will give you the dartforcetodo.html page.

8) Now we are going to work on the realtime sugar, first of all we are going to adapt the html code.

Put this between the body:

	<h1>Dart force todo</h1>
    
    <p>Hello world from Dart!</p>
    
    <input id="input" value="todo" />
    <button id="btn" type="button">OK</button>
    <div id="list">
      
    </div>

9) Then we are going to adapt the clientside dart code, so open dartforcetodo.dart.

10) First of all we need to import the browser package.

	import 'package:force/force_browser.dart';
	
11) Then we are going to create ForceClient object, add the following code just above the main function.

	ForceClient fc;

12) In the main function we are going to instantiate ForceClient. And open a connection to our server.

	fc = new ForceClient();
  	fc.connect();

13) In the html page we have a button, so when a user clicks on a button we need to send the input to all the other clients. 
So when the user clicks on the button we execute the function broadcast.

	querySelector("#btn")
      ..onClick.listen(broadcast);
      
14) Create the function broadcast.

	void  broadcast(MouseEvent event) {
	  ...
	}

15) In this function we will get the input value of the user and send them to all the other clients. Put this in the broadcast function.

	InputElement input = querySelector("#input");  
	var data = {"todo": input.value};
	fc.send("add", data);

16) Now we need to go back to our server and listen to "add" events. Add this to server.dart in the main function.

	fs.on("add", (fme, sender) {
    	sender.send("update", fme.json);
  	});	
  	
17) So we send a "update" event to all the clients, so the only thing we need to programme is a listener on "update" event.
This will fill a list with todo items.

	fc.on("update", (fme, sender) {
    	querySelector("#list").appendHtml("<div>${fme.json["todo"]}</div>");
  	});
  	
18) Now build your clientside code with Tools > Pub build (generates JS)

19) Wait until you have a build folder with the generated files in!

20) After all of this you are ready to test your code by right clicking on the 'server.dart' file, and push on the menu item 'Run'.

This is all it takes to create a small realtime todo app in dart :) 
  