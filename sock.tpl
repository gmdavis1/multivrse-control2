<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.7/semantic.min.css" />
</head>
<body>
<div class="ui container">
    <h2>Provide access to S3 notifications via AWS Websockets</h2>
    <a href="/">Create an audio file</a>
	<p>Uses JS Implementaton of websockets see https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API </p>
	<p>Messages/Notification should be deleted/removed from the queue once read. This can be done within the lambda function that
	manages sockets and queue operations.</p>
    <table class="striped ui  large table">
        <thead>
            <tr>
                <th class="three wide">file</th>
                <!-- <th class="one wide">URL</th> -->
                <th class="one wide">size</th>


            </tr>
        </thead>
        <tbody id="updates"></tbody>
        </table>
</div>


</body>


<script>
var message = ''
// 
var action = JSON.parse('{"action": "sendmessage"}')
const socket = new WebSocket('wss://rfgjune292.execute-api.us-east-2.amazonaws.com/production');

// socket.send(message)

socket.onmessage = function(event){
    message = JSON.parse(event.data).message
    console.log(message)
};


// function getFile(){

//     socket.send(action)
//     if (message.audio){
//         console.log("We found an audio file")
//         $("#updates").append(`<tr><td><a href="https://mttsbucket.s3.us-east-2.amazonaws.com/${message.audio}">${message.audio}</a></td><td>${message.size}</td></tr>`)
//     }
    
// }
// setInterval(getFile, 3000)
</script>


</html>
