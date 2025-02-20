#!/bin/bash

# Define project directory inside the GitHub repo
PROJECT_DIR="about-me-chat-bot"

# Create the folder structure
echo "Creating project directories..."
mkdir -p $PROJECT_DIR/{templates,static/css,static/js,static/images}

# Create placeholder files
echo "Creating placeholder files..."
touch $PROJECT_DIR/requirements.txt
touch $PROJECT_DIR/templates/ask_about_me_chat.html
touch $PROJECT_DIR/static/css/main.css
touch $PROJECT_DIR/static/css/noscript.css
touch $PROJECT_DIR/static/js/main.js
touch $PROJECT_DIR/static/images/placeholder.png
touch $PROJECT_DIR/.gitignore
touch $PROJECT_DIR/README.md

# Add default content to .gitignore
echo "Adding default .gitignore..."
cat <<EOL > $PROJECT_DIR/.gitignore
__pycache__/
*.pyc
.env
venv/
EOL

# Add default content to README.md
echo "Setting up README.md..."
cat <<EOL > $PROJECT_DIR/README.md
# About Me Chatbot

This chatbot references my resume and life notes to answer questions about my background and experience.

## Structure
- **templates/** - HTML templates for the web interface.
- **static/css/** - CSS files for styling.
- **static/js/** - JavaScript files for frontend functionality.
- **static/images/** - Image assets.
EOL

# Add example content to application.py
echo "Setting up example application.py..."
cat <<EOL > $PROJECT_DIR/application.py
from flask import Flask, request, jsonify, render_template
import openai
import os

application = Flask(__name__)

@application.route("/")
def home():
    return render_template("ask_about_me_chat.html")

@application.route("/api/chat", methods=["POST"])
def chat():
    user_input = request.json.get("query")
    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=user_input,
        max_tokens=150
    )
    return jsonify({"response": response.choices[0].text.strip()})

if __name__ == "__main__":
    application.run(debug=True)
EOL

# Add example content to ask_about_me_chat.html
echo "Setting up example ask_about_me_chat.html..."
cat <<EOL > $PROJECT_DIR/templates/ask_about_me_chat.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Me Chatbot - Ryan Pierce</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/main.css') }}">
    <link rel="stylesheet" href="{{ url_for('static', filename='css/noscript.css') }}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="wrapper">
        <header id="header">
            <h1>Chat with Ryan Pierce's Experience Bot</h1>
            <p>Ask about my experience and background.</p>
        </header>
        <div id="main">
            <section id="content" class="main">
                <textarea id="userInput" rows="4" placeholder="Type your question here..."></textarea>
                <br>
                <button id="sendButton" class="button primary">Ask</button>
                <button id="clearButton" class="button primary">Clear Chat</button>
                <div id="chatOutput"></div>
                <p class="disclaimer">
                    <strong>Disclaimer:</strong> This chatbot is powered by AI and provides responses based on Ryan Pierce's resume and life notes. The information provided by the chatbot is for informational purposes only and may not be entirely accurate or up-to-date.
                </p>
            </section>
        </div>
    </div>
    <script src="{{ url_for('static', filename='js/main.js') }}"></script>
</body>
</html>
EOL

# Add example content to main.css
echo "Setting up example main.css..."
cat <<EOL > $PROJECT_DIR/static/css/main.css
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
}
.button {
    padding: 10px 20px;
    margin: 5px;
    background-color: #007BFF;
    color: white;
    border: none;
    cursor: pointer;
}
.button.primary {
    background-color: #007BFF;
}
.button.primary:hover {
    background-color: #0056b3;
}
EOL

# Add example content to main.js
echo "Setting up example main.js..."
cat <<EOL > $PROJECT_DIR/static/js/main.js
$(document).ready(function() {
    $('#sendButton').click(function() {
        var userInput = $('#userInput').val();
        $.ajax({
            url: '/api/chat',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ query: userInput }),
            success: function(response) {
                $('#chatOutput').append('<p><strong>Chatbot:</strong> ' + response.response + '</p>');
            }
        });
    });
    $('#clearButton').click(function() {
        $('#chatOutput').empty();
    });
});
EOL

# Add example content to python.config
echo "Setting up example python.config..."
cat <<EOL > $PROJECT_DIR/.ebextensions/python.config
packages:
  yum:
    python3: []
    python3-pip: []

container_commands:
  01_migrate:
    command: "python3 application.py"
EOL

# Success message
echo "Project setup complete!"
