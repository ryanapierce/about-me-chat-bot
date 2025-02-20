import json
import openai
from openai import OpenAI
import boto3
import os

# AWS S3 Config (For Resume & Life Notes)
S3_BUCKET = "ryan-pierce-bot-data"
LIFE_NOTES_FILE = "life_notes.json"
RESUME_FILE = "Ryan_Pierce_Resume.txt"
s3_client = boto3.client("s3")

# AWS Secrets Manager configuration
AWS_REGION = "us-east-1"
SECRET_NAME = "OPENAI_API_KEY"

def get_openai_api_key():
    """Fetch OpenAI API key from AWS Secrets Manager."""
    session = boto3.session.Session()
    client = session.client(service_name="secretsmanager", region_name=AWS_REGION)
    
    try:
        secret_value = client.get_secret_value(SecretId=SECRET_NAME)
        return json.loads(secret_value["SecretString"])["OPENAI_API_KEY"]
    except Exception as e:
        print(f"ERROR: Unable to retrieve OpenAI API Key: {e}")
        return None

# Retrieve API key
OPENAI_API_KEY = get_openai_api_key()
if not OPENAI_API_KEY:
    raise RuntimeError("OpenAI API key could not be retrieved.")

# Initialize OpenAI client
client = OpenAI(api_key=OPENAI_API_KEY)

def get_file_from_s3(file_name):
    """Retrieve file content from S3."""
    try:
        response = s3_client.get_object(Bucket=S3_BUCKET, Key=file_name)
        return response["Body"].read().decode("utf-8")
    except Exception as e:
        print(f"ERROR: Fetching {file_name} from S3 failed: {e}")
        return None

def lambda_handler(event, context):
    """Handles API requests and logs errors."""
    
    print(f"Received event: {json.dumps(event, indent=2)}")  # Debugging log

    # Fix: Check both REST API (`httpMethod`) and HTTP API (`requestContext.http.method`)
    http_method = event.get("httpMethod") or event.get("requestContext", {}).get("http", {}).get("method")

    if http_method == "OPTIONS":
        print("Handling CORS preflight request")
        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Methods": "OPTIONS, POST",
                "Access-Control-Allow-Headers": "Content-Type"
            },
            "body": json.dumps({"message": "CORS preflight successful"})
        }

    # Load Resume & Life Notes from S3
    life_notes = get_file_from_s3(LIFE_NOTES_FILE)
    resume_text = get_file_from_s3(RESUME_FILE)

    if not life_notes or not resume_text:
        print("ERROR: Failed to load S3 data")
        return {
            "statusCode": 500,
            "headers": {"Access-Control-Allow-Origin": "*"},
            "body": json.dumps({"error": "Failed to load reference data from S3"})
        }

    # Handle normal chatbot requests (`POST`)
    if http_method == "POST":
        try:
            data = json.loads(event["body"])
            print(f"User Input: {data}")  # Debugging log

            if "query" not in data:
                print("ERROR: 'query' missing from request body")
                return {
                    "statusCode": 400,
                    "headers": {"Access-Control-Allow-Origin": "*"},
                    "body": json.dumps({"error": "'query' field is required"})
                }

            user_input = data["query"].strip()
            if not user_input:
                print("WARNING: Empty query received")
                return {
                    "statusCode": 400,
                    "headers": {"Access-Control-Allow-Origin": "*"},
                    "body": json.dumps({"error": "Empty query received"})
                }

            system_prompt = f"""
            You are a chatbot that provides insights into Ryan Pierce's professional background. Respond in a natural, friendly way. Use correct grammar and punctuation.
            Reference the following data but do not explicitly mention that they come from stored files.

            Resume:
            {resume_text}

            Life Notes:
            {life_notes}

            User Query: {user_input}
            """

            response = client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": user_input}
                ],
                max_tokens=200
            )

            chatbot_reply = response.choices[0].message.content

            print(f"Chatbot Response: {chatbot_reply}")  # Debugging log

            return {
                "statusCode": 200,
                "headers": {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Methods": "OPTIONS, POST",
                    "Access-Control-Allow-Headers": "Content-Type"
                },
                "body": json.dumps({"response": chatbot_reply})
            }
        except Exception as e:
            print(f"ERROR: Exception occurred - {e}")  # Debugging
            return {
                "statusCode": 500,
                "headers": {"Access-Control-Allow-Origin": "*"},
                "body": json.dumps({"error": "Internal Server Error"})
            }

    return {
        "statusCode": 405,
        "headers": {"Access-Control-Allow-Origin": "*"},
        "body": json.dumps({"error": "Method not allowed"})
    }
