library dart_force_todo;

import "package:force/force_serverside.dart";

void main() {
  
  ForceServer fs = new ForceServer(clientFiles: "../build/web/", startPage: "dartforcetodo.html");
  
  fs.setupConsoleLog();
  
  fs.on("add", (fme, sender) {
    sender.send("update", fme.json);
  });
  
  fs.start();
  
}