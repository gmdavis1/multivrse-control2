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
                <div class="ui container">
                    <form class="ui form", action="/send_json" method="POST">
                        <div class="ui segment very padded">
                            <div class="field">
                                <input type="hidden" name="json" value='{"scene": "intro", "action": "changescene", "value": "doctor"}'>
                            </div>
                            <div>
                                <button class="ui primary fluid button" type="submit" style="background-color: blue">SCENE CHANGE: INTRO -> DOCTOR</button>
                            </div>
                        </div>
                    </form>
                </div>

                <form class="ui form", action="/audiofile/doctor" method="POST">
                    <div class="ui segment very padded">
                        <div class="field">
                            <label>Doctor speech</label>
                            %if focus == "doctor":
                            <input type="text" name="text"  placeholder=" " autofocus>
                            %else:
                            <input type="text" name="text"  placeholder=" ">
                            %end
                        </div>

                        <div>
                            <button class="ui primary fluid button" type="submit" style="background-color: grey">SEND DOCTOR SPEECH</button>
                        </div>
                    </div>
                </form>

                <form class="ui form", action="/audiofile/doctor" method="POST">
                    <div class="field">
                        <input type="hidden" name="text" value="Sorry, I didn't understand that. Can you repeat it please?">
                    </div>
                    
                    <div class="ui segment padded">
                        <button class="ui primary fluid button" type="submit" style="background-color: black;">Sorry, I didn't understand that. Can you repeat it please?</button>
                    </div>
                </form>

                %for line in lines_doctor:
                <form class="ui form", action="/audiofile/doctor" method="POST">
                    <div class="field">
                        <input type="hidden" name="text" value="{{line}}">
                    </div>

                    <div>
                        <button class="ui primary fluid button" type="submit" style="background-color: grey">{{line}}</button>
                    </div>
                </form>
                %end

                <div class="ui container">
                    <form class="ui form", action="/send_json" method="POST">
                        <div class="ui segment very padded">
                            <div class="field">
                                <input type="hidden" name="json" value='{"scene": "doctor", "action": "changescene", "value": "intro"}'>
                            </div>
                            <div>
                                <button class="ui primary fluid button" type="submit" style="background-color: blue">SCENE CHANGE: DOCTOR -> INTRO</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>


            <div class="column">
                <div class="ui container">
                    <form class="ui form", action="/send_json" method="POST">
                        <div class="ui segment very padded">
                            <div class="field">
                                <input type="hidden" name="json" value='{"scene": "intro", "action": "changescene", "value": "garage"}'>
                            </div>
                            <div>
                                <button class="ui primary fluid button" type="submit" style="background-color: blue">SCENE CHANGE: INTRO -> GARAGE</button>
                            </div>
                        </div>
                    </form>
                </div>

                <form class="ui form", action="/audiofile/garage" method="POST">
                    <div class="ui segment very padded">
                        <div class="field">
                            <label>Mechanic speech</label>
                            %if focus == "garage":
                            <input type="text" name="text"  placeholder=" " autofocus>
                            %else:
                            <input type="text" name="text"  placeholder=" ">
                            %end
                        </div>

                        <div>
                            <button class="ui primary fluid button" type="submit" style="background-color: green">SEND MECHANIC SPEECH</button>
                        </div>
                    </div>
                </form>

                <form class="ui form", action="/audiofile/garage" method="POST">
                    <div class="field">
                        <input type="hidden" name="text" value="Sorry, I didn't understand that. Can you repeat it please?">
                    </div>
                    
                    <div class="ui segment padded">
                        <button class="ui primary fluid button" type="submit" style="background-color: darkgreen">Sorry, I didn't understand that. Can you repeat it please?</button>
                    </div>
                </form>

                %for line in lines_mechanic:
                <form class="ui form", action="/audiofile/garage" method="POST">
                    <div class="field">
                        <input type="hidden" name="text" value="{{line}}">
                    </div>

                    <div>
                        <button class="ui primary fluid button" type="submit" style="background-color: green">{{line}}</button>
                    </div>
                </form>
                %end

                <div class="ui container">
                    <form class="ui form", action="/send_json" method="POST">
                        <div class="ui segment very padded">
                            <div class="field">
                                <input type="hidden" name="json" value='{"scene": "garage", "action": "changescene", "value": "intro"}'>
                            </div>
                            <div>
                                <button class="ui primary fluid button" type="submit" style="background-color: blue">SCENE CHANGE: GARAGE -> INTRO</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>

        </div>
    </div>

    <div class="ui container">
        <form class="ui form", action="/send_json" method="POST">
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