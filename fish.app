var RaspiCam = require("raspicam");
var express    = require('express')    

var camera = new RaspiCam({mode:"photo", rotation:180, width: 1024, height: 768, timeout:100, brightness: 65, exposure: "auto",  output:"/home/pi/rcpi/photo.jpg" });

//to take a snapshot, start a timelapse or video recording
camera.start( );

//to stop a timelapse or video recording
camera.stop( );

//listen for the "start" event triggered when the start method has been successfully initiated
camera.on("start", function(){
	//do stuff
});

//listen for the "read" event triggered when each new photo/video is saved
camera.on("read", function(err, timestamp, filename){ 
	//do stuff
});

//listen for the "stop" event triggered when the stop method was called
camera.on("stop", function(){
	//do stuff
});

//listen for the process to exit when the timeout has been reached
camera.on("exit", function(){
	//do stuff
});

app = express();


app.get('/', function(req, res){
    camera.start()
    res.sendFile('index.html', {root: __dirname});

});

app.get('/photo.jpg', function(req, res){
    res.sendFile('photo.jpg', {root: __dirname});

});

app.get('/feed', function(req, res){
    res.sendFile('index.html', {root: __dirname});
    var spawn = require("child_process").spawn;
    var process = spawn('python',["motor-shield/feed.py"]);
    console.log('run feed');
});

app.listen(80);
console.log('Express server started');


