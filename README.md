# Experience Chatbot

This project is an **AI-powered chatbot** designed to provide insights into **professional backgrounds, experiences, and expertise.** The chatbot is integrated with OpenAI’s **GPT-3.5-turbo**, utilizing structured data from **resume documents** and **life notes** to generate personalized responses.

---

## 🚀 Tech Stack

### 🔹 Backend
- **AWS Lambda & API Gateway** (Serverless architecture for handling requests)
- **OpenAI API** (GPT-powered responses based on structured data)
- **AWS Secrets Manager** (Secure API key storage)
- **AWS S3** (Stores resume files and life notes)

### 🔹 Frontend
- **HTML, CSS, JavaScript (jQuery)** (Interactive UI)
- **GitHub Pages** (Static hosting for public access)

### 🔹 Deployment
- **AWS Lambda & API Gateway** (Serverless API handling)
- **AWS CloudWatch** (Logs all chatbot interactions)
- **AWS S3** (Stores structured user data)

### 🔹 Security
- **AWS IAM Roles & Policies** (Access control for Lambda & API Gateway)
- **AWS Secrets Manager** (Encrypts and retrieves API keys securely)

---

## ✨ Features
✔ **Conversational AI** trained on professional backgrounds  
✔ **Serverless & Scalable Architecture** using AWS Lambda  
✔ **Secure OpenAI API Key Storage** with AWS Secrets Manager  
✔ **Customizable Resume & Life Notes Storage** in AWS S3  
✔ **GitHub Pages Integration** for easy public access  

---

## 🛠 How It Works
1. **User submits a question** about work history, skills, or education.  
2. **API Gateway routes the request** to AWS Lambda.  
3. **Lambda retrieves structured data** from AWS S3 and **generates a query prompt** for OpenAI.  
4. **OpenAI API processes the query** and **returns a response.**  
5. **Response is sent back** to the frontend and displayed to the user.  

---

## 📖 Step-by-Step Guide

This guide walks through the process of building and deploying an AI-powered chatbot that answers user queries based on structured data. The chatbot leverages AWS Lambda, API Gateway, OpenAI API, AWS S3, and GitHub Pages for hosting.

### 📌 Step 1: Set Up AWS Lambda Backend

1. **Create a Lambda Function**
    - Open AWS Lambda → Click Create Function.
    - Select Author from scratch.
    - Set a function name (e.g., `chatbot-handler`).
    - Choose Python 3.x as the runtime.
    - Assign an IAM role with the following permissions:
        - `secretsmanager:GetSecretValue` (for API key retrieval)
        - `s3:GetObject` (for fetching structured data)
        - `logs:CreateLogStream`, `logs:PutLogEvents` (for logging)

2. **Implement Lambda Function**
    - The function:
        - Retrieves the OpenAI API key securely from AWS Secrets Manager.
        - Loads chatbot knowledge base (e.g., a JSON file from S3).
        - Generates responses using OpenAI.
        - Returns responses as JSON.

3. **Deploy Lambda Function**
    - Zip your script and dependencies.
    - Upload the ZIP file to your Lambda function.
    - Set the handler to `lambda_function.lambda_handler`.

### 📌 Step 2: Set Up API Gateway

1. Navigate to AWS API Gateway → Create API.
2. Choose REST API → New API.
3. Click Create Method → POST.
4. Link it to your Lambda function.
5. Enable CORS.
6. Deploy the API and copy the invoke URL.

### 📌 Step 3: Build the Frontend

The chatbot's UI is built using HTML, CSS, and JavaScript with jQuery to interact with the backend.

1. **Create the Chat Interface**

2. **Deploy the Frontend on GitHub Pages**
    - Commit your HTML, CSS, and JavaScript files to a GitHub repository.
    - Enable GitHub Pages in Repository Settings.
    - Set the branch to `main` and source as `/` (root).
    - Access your chatbot UI via `https://your-github-username.github.io/chatbot/`.

### 📌 Step 4: Secure the System

1. **Use AWS Secrets Manager**
    - Store the OpenAI API Key securely.
    - Use IAM Roles to grant only necessary access.

2. **Enable Logging & Monitoring**
    - Enable AWS CloudWatch Logs for Lambda.
    - Add logs to track API requests:
        ```python
        import logging
        logger = logging.getLogger()
        logger.setLevel(logging.INFO)
        logger.info(f"User input: {user_input}")
        ```

3. **Restrict API Access**
    - Enable CORS in API Gateway.
    - Use IAM policies to control Lambda execution.

---