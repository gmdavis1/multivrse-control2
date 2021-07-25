from bottle import template, request, Bottle, redirect
import json
import requests
BASE = Bottle()
from websocket import create_connection
from google.cloud import texttospeech

CLOUD_FUNCTION_URL = "https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize"
SOCKET_URL = "wss://e5pvp3ghmc.execute-api.us-east-2.amazonaws.com/Prod"

VOICES = {
    "garage": {
        "voice": {"name": "en-US-Wavenet_D", "ssmlGender": texttospeech.SsmlVoiceGender.MALE},
        "speed": 0.9, 
        "pitch": 0
    },
    "doctor": {
        "voice": {"name": "en-US-Wavenet_D", "ssmlGender": texttospeech.SsmlVoiceGender.MALE}, 
        "speed": 0.9, 
        "pitch": 0
    },
}

LINES_MECHANIC = []
with open("lines-mechanic.txt") as f:
    LINES_MECHANIC = f.read().splitlines()

LINES_DOCTOR = []
with open("lines-doctor.txt") as f:
    LINES_DOCTOR = f.read().splitlines()

@BASE.route('/')
def index():
    return template('index.tpl', focus="none", 
        lines_mechanic = LINES_MECHANIC, 
        lines_doctor = LINES_DOCTOR)

@BASE.route('/<scene>')
def index(scene):
    return template('index.tpl', focus=scene, 
        lines_mechanic = LINES_MECHANIC, 
        lines_doctor = LINES_DOCTOR)

@BASE.route('/audiofile/<scene>', method="POST")
def audiofile(scene):
    t = request.POST['text']
    scene_voice = VOICES[scene]
    resp = requests.post(
        CLOUD_FUNCTION_URL,
        json = {'text': t, 
                "voice": scene_voice["voice"],
                "speed": scene_voice["speed"],
                "pitch": scene_voice["pitch"]}
    )
    filepath = resp.json()["file"]
    print(f"Audio file for {scene.upper()}: \"{t}\" created at {filepath}")

    # connect to websocket and send json with the instructions/filepath, then close
    # don't need to keep the socket open here because only sending and never receiving
    ws = create_connection(SOCKET_URL)
    message = {
        "action": "sendmessage",
        "data": {
            "scene": scene,
            "action": "playaudio",
            "value": filepath
        }
    }
    sock_json = json.dumps(message)
    print(f"Sending JSON {sock_json} through websocket {SOCKET_URL}")
    ws.send(sock_json)
    ws.close()

    redirect('/' + scene)

@BASE.route('/send_json', method="POST")
def send_json():
    arb_json = json.loads(request.POST["json"])
    print(arb_json)
    ws = create_connection(SOCKET_URL)
    message = {
        "action": "sendmessage",
        "data": arb_json
    }
    sock_json = json.dumps(message)
    print(f"Sending JSON {sock_json} through websocket {SOCKET_URL}")
    ws.send(sock_json)
    ws.close()

    redirect('/')
