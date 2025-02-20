#!/bin/bash

# Define project directory inside the GitHub repo
PROJECT_DIR="experience-chat-bot"

# Create the folder structure
echo "Creating project directories..."
mkdir -p $PROJECT_DIR/{templates,static/css,static/js,static/images}

# Create placeholder files
echo "Creating placeholder files..."
touch $PROJECT_DIR/requirements.txt
touch $PROJECT_DIR/templates/ask_about_me_chat.html
touch $PROJECT_DIR/static/css/main.css
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

This chatbot references resume and notes to answer questions about the developer's background and experience.

## Structure
- **static/css/** - CSS files for styling.
EOL

# Add example content to ask_about_me_chat.html
echo "Setting up example ask_about_me_chat.html..."
cat <<EOL > $PROJECT_DIR/templates/ask_about_me_chat.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatbot Example</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta http-equiv="Content-Security-Policy" content="connect-src 'self' https://api.example.com;">
</head>
<body>
    <div id="wrapper">
        <header id="header">
            <h1>Chat with Experience Bot</h1>
            <p>Ask about experience and background.</p>
        </header>
        <div id="main">
            <section id="content" class="main">
                <textarea id="userInput" rows="4" placeholder="Type your question here..."></textarea>
                <br>
                <button id="sendButton" class="button primary">Ask</button>
                <button id="clearButton" class="button primary">Clear Chat</button>
                <div id="chatOutput"></div>
                <p class="disclaimer">
                    <br>
                    <strong>Disclaimer:</strong> This chatbot is powered by AI and provides responses based on predefined data. 
                    The information provided by the chatbot is for informational purposes only and may not be entirely accurate or up-to-date.
                </p>
            </section>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            const BACKEND_URL = "https://api.example.com/chat";

            function escapeHtml(text) {
                var map = {
                    '&': '&amp;',
                    '<': '&lt;',
                    '>': '&gt;',
                    '"': '&quot;',
                    "'": '&#039;'
                };
                return text.replace(/[&<>"']/g, function(m) { return map[m]; });
            }
    
            function sendMessage() {
                var userInput = $('#userInput').val().trim();
                if (!userInput) {
                    alert('Please enter a question or comment.');
                    return;
                }
    
                $('#chatOutput').append('<p><strong>You:</strong> ' + escapeHtml(userInput) + '</p>');
    
                $.ajax({
                    url: BACKEND_URL,
                    type: "POST",
                    contentType: "application/json",
                    crossDomain: true,
                    data: JSON.stringify({ query: userInput }),
                    success: function(response) {
                        console.log("API Response:", response); // Debugging
                        try {
                            var jsonResponse = typeof response === "string" ? JSON.parse(response) : response;
                            if (jsonResponse.response) {
                                $('#chatOutput').append('<p><strong>Chatbot:</strong> ' + escapeHtml(jsonResponse.response) + '</p>');
                            } else {
                                $('#chatOutput').append('<p><strong>Chatbot:</strong> No valid response received.</p>');
                            }
                        } catch (e) {
                            console.error("Parsing Error:", e);
                            $('#chatOutput').append('<p><strong>Chatbot:</strong> Error processing response.</p>');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("API Error:", xhr.responseText || error);
                        $('#chatOutput').append('<p><strong>Chatbot:</strong> Error processing request.</p>');
                    }
                });
            }
    
            $('#sendButton').click(sendMessage);
            $('#clearButton').click(function() { $('#chatOutput').empty(); });

            $('#userInput').keypress(function(event) {
                if (event.which === 13 && !event.shiftKey) {
                    event.preventDefault();
                    sendMessage();
                }
            });
        });
    </script>    
</body>
</html>
EOL

# Add example content to main.css
echo "Setting up example main.css..."
cat <<EOL > $PROJECT_DIR/static/css/main.css
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

#wrapper {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

header {
    text-align: center;
    margin-bottom: 20px;
}

header h1 {
    margin: 0;
    font-size: 2em;
}

header p {
    color: #666;
}

#main {
    padding: 20px;
}

textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    padding: 10px 20px;
    margin-right: 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button.primary {
    background-color: #007bff;
    color: #fff;
}

button.primary:hover {
    background-color: #0056b3;
}

#chatOutput {
    margin-top: 20px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
}

#chatOutput p {
    margin: 10px 0;
}

.disclaimer {
    font-size: 0.9em;
    color: #999;
}

footer {
    text-align: center;
    margin-top: 20px;
    padding: 10px;
    background-color: #f4f4f4;
    border-top: 1px solid #ccc;
}

footer p {
    margin: 0;
    font-size: 0.9em;
    color: #666;
}

footer a {
    color: #007bff;
    text-decoration: none;
}

footer a:hover {
    text-decoration: underline;
}
EOL

# Add example content to main.js
echo "Setting up example main.js..."
cat <<EOL > $PROJECT_DIR/static/js/main.js
$(document).ready(function() {
    $('#sendButton').click(function() {
        var userInput = $('#userInput').val();
        $.ajax({
            url: 'https://api.example.com/chat',
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

# Success message
echo "Project setup complete!"