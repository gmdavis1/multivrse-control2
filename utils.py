import boto3
import json
sqs = boto3.resource('sqs')
queue = sqs.Queue('https://sqs.us-east-2.amazonaws.com/652851170346/mtts')


def new_message():
    """Recieve/Retrieve message from queue."""
    message = queue.receive_messages(WaitTimeSeconds=1)
    try:
        return json.loads(str(message[0].body))['Records'][0]['s3']['object']
    except Exception as e:
        print(e)
        #['Records'][0].object
