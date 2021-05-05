import json
import boto3

sqs = boto3.resource('sqs')
queue = sqs.Queue('https://sqs.us-east-2.amazonaws.com/652851170346/mtts')


def new_message():
    """Recieve/Retrieve message from queue."""
    try:
        message = json.loads(queue.receive_messages(WaitTimeSeconds=2)[0].body)
        if message['Records'][0]['eventName'] == "ObjectCreated:Put":
            return {
                "audio": message['Records'][0]['s3']['object']['key'],
                "size": message['Records'][0]['s3']['object']['size']}
    except Exception as e:
        return e

def lambda_handler(event, context):
    try:
        route_key = event['requestContext']['routeKey']
    except:
        route_key = None
    response = {'statusCode':None, 'body':None}
    if route_key in ['$connect', '$disconnect']:
        response['statusCode'] = 200
        return response
    elif route_key in ['sendmessage', '$default']:
        try:
            audio_file = new_message()
            response['statusCode'] = 200
            response['body'] = json.dumps({'message': audio_file})
            return response
        except Exception as err:
            response['statusCode'] = 404
            response['body'] = json.dumps({'message': str(err)})
            return response

