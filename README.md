
# GitHub Search API with UIKit & Firebase Authentication

🔍 **GitHub Search API** project built with **Swift 5** that demonstrates how to implement the GitHub search functionality in an iOS app using **UIKit**. The app integrates **Firebase Authentication** for user login and registration and follows a clean architecture approach using **MVVM**, **Builder Pattern**, and **Coordinator** patterns.

## 🚀 Project Overview

This project allows users to search GitHub repositories using the GitHub Search API. The app demonstrates how to handle user authentication via **Firebase** and display search results in a clean, modular architecture. The architecture follows the **MVVM** pattern for separating concerns, the **Builder Pattern** for clean configuration of objects, and the **Coordinator** pattern for handling navigation flow.

## 🛠 Technologies Used

- **Swift 5**
- **UIKit**
- **Firebase Authentication**
- **MVVM Architecture**
- **Builder Pattern**
- **Coordinator Pattern**
- **GitHub Search API**

## 🔑 Features

- **GitHub Repository Search**: Search GitHub repositories by name, description, or other keywords.
- **Firebase Authentication**: Sign up, login, and manage user authentication using Firebase.
- **MVVM Architecture**: Clean separation between UI, business logic, and data.
- **Builder Pattern**: Easily construct and manage the configuration of various authentication and API requests.
- **Coordinator Pattern**: Manages navigation and ensures that view controllers are decoupled from each other.

## 🧩 Architecture Overview

### **MVVM (Model-View-ViewModel)**

- **Model**: The data layer, responsible for communicating with the GitHub API and Firebase.
- **View**: The UI layer, responsible for displaying data and handling user interaction.
- **ViewModel**: Acts as a middle layer between the Model and View, handling logic and preparing data for the View.

### **Builder Pattern**

- Used to simplify and modularize the construction of complex objects, such as API requests and user authentication.

### **Coordinator Pattern**

- Ensures the app's navigation flow is cleanly separated from the ViewControllers, improving scalability and modularity.

## 💡 Future Improvements

- **Error Handling**: Add detailed error handling for Firebase and GitHub API responses.
- **Search Filters**: Introduce search filters for more refined results.
- **User Profile**: Display the authenticated user's profile once logged in.

## 📱 Screenshots


---

🏆 Created by Krzysztof Lema | [GitHub](https://github.com/KrzysztofLema) | [LinkedIn](https://www.linkedin.com/in/krzysztoflema/)
