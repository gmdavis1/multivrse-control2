<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.7/semantic.min.css" />
</head>
<body>
<div class="ui container">
    <h2>Provides access to AWS S3 notifications via AWS SQS</h2>
    <h3 class="ui segment">Audio files are auto-deleted after 5mins. Please wait we are polling the queue for a file</h3>
    <a href="/">Create an audio file</a>
    <p>NOTE: Files can be set to expire or delete via delete_message() after use. Files are not automatically removed from the queue when pulled in<br></p>
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
var action = JSON.parse('{"action": "sendmessage"}')
const socket = new WebSocket('wss://rfgjune292.execute-api.us-east-2.amazonaws.com/production');
socket.onmessage = function(event){
    message = JSON.parse(event.data).message
    console.log(message)
};
function getFile(){

    socket.send(action)
    if (message.audio){
        console.log("We found an audio file")
        $("#updates").append(`<tr><td><a href="https://mttsbucket.s3.us-east-2.amazonaws.com/${message.audio}">${message.audio}</a></td><td>${message.size}</td></tr>`)
    }
    
}
setInterval(getFile, 3000)
</script>


</html>
