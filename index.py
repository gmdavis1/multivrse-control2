from bottle import template, request, Bottle, redirect
import json
import requests
BASE = Bottle()
from websocket import create_connection

CLOUD_FUNCTION_URL = "https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize"
SOCKET_URL = "wss://rfgjune292.execute-api.us-east-2.amazonaws.com/production"

MECHANIC_VOICE = {"voice": "en-US-Wavenet_D", "speed": 1.0, "pitch": 0}

@BASE.route('/')
def index():
    return template('index.tpl')

@BASE.route('/audiofile', method=['GET', 'POST'])
def audiofile():
    t = request.POST['text']
    resp = requests.post(
        CLOUD_FUNCTION_URL,
        json = {'text': t, 
                "voice": MECHANIC_VOICE["voice"],
                "speed": MECHANIC_VOICE["speed"],
                "pitch": MECHANIC_VOICE["pitch"]}
    )
    filepath = resp.json()["file"]
    print(f"Audio file for {t} created at {filepath}")

    # connect to websocket and send json with the instructions/filepath, then close
    # don't need to keep the socket open here because only sending and never receiving
    ws = create_connection(SOCKET_URL)
    message = {
        "type": "audio",
        "url": filepath
    }
    ws.send(json.dumps(message))
    ws.close()

    redirect('/')
