from secrets import token_hex

from google.cloud import texttospeech
import boto3
from flask import jsonify

client = texttospeech.TextToSpeechClient()
boto3s3 = boto3.client('s3')


def synthesize_text(request):
    """Run text to speech."""

    source_text = request.get_json(force=True)
    text = texttospeech.SynthesisInput(text=source_text.get('source_text'))
    voice = texttospeech.VoiceSelectionParams(
        language_code="en-US",
        name="en-US-Standard-C",
        ssml_gender=texttospeech.SsmlVoiceGender.FEMALE,
    )
    config = texttospeech.AudioConfig(
        audio_encoding=texttospeech.AudioEncoding.MP3
    )
    return client.synthesize_speech(
        request={"input": text, "voice": voice, "audio_config": config}
    )


    # # return jsonify({'data': str(binary_data.audio_content), 'status': 'ok'})
    # with open("output.mp3", "wb") as out:
    # # Write the response to the output file.
    #     out.write(binary_data.audio_content)
    #     print('Audio content written to file "output.mp3"')
    #     return 'OK'


def upload_to_s3(binary_data, filename):
    """Upload audio content to s3 bucket"""

    return boto3s3.put_object(
        Body=binary_data.audio_content,
        Bucket='mttsbucket',
        Key=filename
    )


def mtts(request):
    """Synthesize and upload.

    Returns link to upload file on s3
    """

    filename = f'{token_hex(8)}.mp4'
    try:
        binary_data = synthesize_text(request)
        amz_response = upload_to_s3(binary_data, filename)
    except Exception as e:
        return {'error': e, 'status': 'fail'}

    return {'file': f'https://mttsbucket.s3.us-east-2.amazonaws.com/{filename}'}
