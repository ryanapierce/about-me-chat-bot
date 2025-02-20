This project is an **AI-powered chatbot** designed to provide insights into **Ryan Pierce’s professional background, experience, and expertise.** The chatbot is integrated with OpenAI’s **GPT-3.5-turbo**, utilizing structured data from **resume documents** and **life notes** to generate personalized responses.  

---

## **🚀 Tech Stack**  

### **🔹 Backend**
- **AWS Lambda & API Gateway** (Serverless architecture for handling requests)
- **OpenAI API** (GPT-powered responses based on structured data)
- **AWS Secrets Manager** (Secure API key storage)
- **AWS S3** (Stores resume files and life notes)

### **🔹 Frontend**
- **HTML, CSS, JavaScript (jQuery)** (Interactive UI)
- **GitHub Pages** (Static hosting for public access)

### **🔹 Deployment**
- **AWS Lambda & API Gateway** (Serverless API handling)
- **AWS CloudWatch** (Logs all chatbot interactions)
- **AWS S3** (Stores structured user data)

### **🔹 Security**
- **AWS IAM Roles & Policies** (Access control for Lambda & API Gateway)
- **AWS Secrets Manager** (Encrypts and retrieves API keys securely)

---

## **✨ Features**
✔ **Conversational AI** trained on Ryan Pierce’s background  
✔ **Serverless & Scalable Architecture** using AWS Lambda  
✔ **Secure OpenAI API Key Storage** with AWS Secrets Manager  
✔ **Customizable Resume & Life Notes Storage** in AWS S3  
✔ **GitHub Pages Integration** for easy public access  

---

## **🛠 How It Works**
1️⃣ **User submits a question** about Ryan Pierce’s work history, skills, or education.  
2️⃣ **API Gateway routes the request** to AWS Lambda.  
3️⃣ **Lambda retrieves structured data** from AWS S3 and **generates a query prompt** for OpenAI.  
4️⃣ **OpenAI API processes the query** and **returns a response.**  
5️⃣ **Response is sent back** to the frontend and displayed to the user.  

---

## **🌐 Live Demo & Source Code**
🎯 **Chatbot Link:** [Interact with the chatbot](https://ryanpierce.dev/assets/projects/about-me-chat-bot/templates/ask_about_me_chat.html)  
💻 **Source Code:** [GitHub Repository](https://github.com/ryanapierce/ryanapierce.github.io/tree/7bf3353f378c46907483b118f185d6afbeeb55a9/assets/projects/about-me-chat-bot)  

---