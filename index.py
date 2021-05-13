from bottle import template, request, Bottle, redirect
import json
import requests
BASE = Bottle()
import utils
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
    filename = resp.json()["file"]
    print(f"Audio file for {t} created at {filename}")

    # connect to websocket and send json with the instructions/filename, then close
    # don't need to keep the socket open here because only sending and never receiving
    ws = create_connection("wss://rfgjune292.execute-api.us-east-2.amazonaws.com/production")
    ws.send(filename)
    ws.close()
    
    redirect('/')

# @BASE.route('/queue', method='GET')
# def queue():
#     msg = utils.new_message()
#     if msg:
#         print(msg)
#         return msg
#     else:
#         return None

# @BASE.route('/sock', method=['GET', 'POST'])
# def sock_et():
#     return template('sock.tpl')
#     # pass parameters to the .tpl 

# @BASE.route('/view-queue')
# def vqueue():
#     return template('poll.tpl')
# if __name__ == '__main__':
#     BASE.run(host='0.0.0.0', reloader=True, debug=True)
