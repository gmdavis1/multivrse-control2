from bottle import template, request, Bottle, redirect
import json
import requests
BASE = Bottle()
import utils

# https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize


@BASE.route('/')
def index():
    return template('index.tpl')


@BASE.route('/audiofile', method=['GET', 'POST'])
def audiofile():
    t = request.POST['text']
    resp = requests.post(
        'https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize',
        json={'source_text': t}
    )
    redirect('/')


@BASE.route('/queue', method='GET')
def queue():
    msg = utils.new_message()
    if msg:
        print(msg)
        return msg
    else:
        return None

@BASE.route('/sock')
def sock_et():
    return template('sock.tpl')

@BASE.route('/view-queue')
def vqueue():
    return template('poll.tpl')
# if __name__ == '__main__':
#     BASE.run(host='0.0.0.0', reloader=True, debug=True)
