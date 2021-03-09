from bottle import template, request, Bottle
import requests
BASE = Bottle()

# https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize


@BASE.route('/')
def index():
    return template('index.tpl')


@BASE.route('/audiofile', method='POST')
def audiofile():
    t = request.POST['text']
    resp = requests.post(
        'https://us-central1-mtts-307011.cloudfunctions.net/tts-synthesize',
        json={'source_text': t}
    )
    return resp.json()

# if __name__ == '__main__':
#     BASE.run(host='0.0.0.0', reloader=True, debug=True)