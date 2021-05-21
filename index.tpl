<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.7/semantic.min.css" />
    <title>MultiVRse control panel</title>
</head>
<body>
    <div class="ui container">
        <div class="ui two column grid">

            <div class="column">
                <form class="ui form", action="/audiofile/garage" method="POST">
                    <div class="ui segment very padded">
                        <div class="field">
                            <label>Mechanic speech</label>
                            %if focus == "garage":
                            <input type="text" name="text"  placeholder="Mechanic text" autofocus>
                            %else:
                            <input type="text" name="text"  placeholder="Mechanic text">
                            %end
                        </div>

                        <div>
                            <button class="ui primary fluid button" type="submit">SEND MECHANIC SPEECH</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="column">
                <form class="ui form", action="/audiofile/doctor" method="POST">
                    <div class="ui segment very padded">
                        <div class="field">
                            <label>Doctor speech</label>
                            %if focus == "doctor":
                            <input type="text" name="text"  placeholder="Doctor text" autofocus>
                            %else:
                            <input type="text" name="text"  placeholder="Doctor text">
                            %end
                        </div>

                        <div>
                            <button class="ui primary fluid button" type="submit">SEND DOCTOR SPEECH</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>

     <div class="ui container">
        <form class="ui form", action="/test_json" method="POST">
            <div class="ui segment very padded">
                <div class="field">
                    <label>Change scene from mechanic to doctor</label>
                    <input type="hidden" name="json" value='{"scene": "garage", "action": "changescene", "value": "doctor"}'>
                </div>
                <div>
                    <button class="ui primary fluid button" type="submit">CHANGE SCENE TO DOCTOR</button>
                </div>
            </div>
        </form>
    </div>

    <div class="ui container">
        <form class="ui form", action="/test_json" method="POST">
            <div class="ui segment very padded">
                <div class="field">
                    <label>Test arbitrary JSON: type in arbitrary json and it will send through the websocket. If the string entered is not in correct json format it will crash</label>
                    <input type="text" name="json" placeholder='{"scene": "garage", "action": "changescene", "value": "doctor"}'>
                </div>
                <div>
                    <button class="ui primary fluid button" type="submit">SEND ARBITRARY JSON</button>
                </div>
            </div>
        </form>
    </div>


</div>
</body>
</html>