#!/bin/bash

# Define project directory inside the GitHub repo
PROJECT_DIR="about_me_chatbot"

# Create the folder structure
echo "Creating project directories..."
mkdir -p $PROJECT_DIR/{backend,frontend,data,.github/workflows}

# Create placeholder files
echo "Creating placeholder files..."
touch $PROJECT_DIR/backend/app.py
touch $PROJECT_DIR/backend/requirements.txt
touch $PROJECT_DIR/frontend/index.html
touch $PROJECT_DIR/data/resume.txt
touch $PROJECT_DIR/data/life_notes.json
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
- **backend/** - Flask API handling chat requests.
- **frontend/** - Web-based chat interface.
- **data/** - Resume (.txt) and life notes (.json).
EOL

# Add example life notes JSON structure
echo "Setting up example life_notes.json..."
cat <<EOL > $PROJECT_DIR/data/life_notes.json
{
  "hobbies": ["hiking", "chess", "coding"],
  "education": "Bachelor's in Finance",
  "career": "Data Engineer at Ford Motor Company"
}
EOL

# Add example resume text
echo "Setting up example resume.txt..."
cat <<EOL > $PROJECT_DIR/data/resume.txt
Ryan A. Pierce  
Data Engineer at Ford Motor Company  
Finance & Analytics Background
EOL

# Success message
echo "Project setup complete!"
