# 🎯 TriviaX - Knowledge Quiz Application

TriviaX is a modern and interactive Quiz Application built using Flutter.  
It supports real-time API-based quizzes and custom quizzes created by an admin.  

The app is designed with a professional UI/UX, smooth animations, dark/light theme support, and clean architecture using GetX state management.

---

## 🚀 Features

### 🧠 Difficulty-Based Quiz System
- Easy / Medium / Hard levels
- Questions fetched from real-time Trivia API
- Dynamic question loading
- Options shuffled every time

### 🌐 Real-Time API Integration
- Uses Trivia API
- Each question contains:
  - 1 Correct Answer
  - 3 Incorrect Answers
- Fresh quiz experience on every attempt

### 👨‍💻 Admin Mode (Custom Quiz Builder)
- Create custom questions
- Add 4 options per question
- Select correct answer visually
- Edit existing questions
- Delete questions
- Difficulty selection per question
- Data stored locally using Hive

### 👤 User Mode
- Attempt API quizzes
- Attempt Admin-created custom quizzes
- Randomized custom question order
- Same scoring & gameplay rules for both modes

### ❤️ Life-Based Gameplay
- 3 Lives per quiz
- Wrong answer reduces 1 life
- Quiz ends when lives are finished

### 🎯 Intelligent Scoring System
- +10 points per correct answer
- Real-time score updates
- Final result screen with performance message

### 🎨 Professional UI/UX
- Clean card-based layout
- Animated transitions
- Smooth color feedback (Green/Red answers)
- Dark Mode & Light Mode support
- Responsive design

---

## 🛠️ Tech Stack

- Flutter
- Dart
- GetX (State Management + Navigation)
- Hive (Local Storage)
- HTTP (API Integration)
- Material 3 UI
- Shimmer (Loading effect)

---

## 📂 Project Structure (MVC Pattern)

lib/
│
├── app/
│ ├── routes.dart
│
├── controller/
│ ├── quiz_controller.dart
│ ├── admin_controller.dart
│
├── data/
│ ├── models/
│ │ ├── questions_model.dart
│ │ ├── custom_model.dart
│ ├── services/
│ │ ├── quiz_service.dart
│
├── view/
│ ├── home_view.dart
│ ├── quiz_view.dart
│ ├── result_view.dart
│ ├── admin_view.dart
│ ├── add_question_view.dart

---

## 📦 API Used

Trivia API:

https://the-trivia-api.com/api/questions?limit=10&difficulty=easy

Parameters:
- limit → number of questions
- difficulty → easy | medium | hard


---

## 🔄 How to Run

1. Clone repository
2. Run:
   flutter pub get
3. Run app:
   flutter run

---

## 💡 Future Improvements

- Timer per question
- Multiple correct answers
- Quiz categories
- Leaderboard
- Cloud sync
- Sound effects
- Confetti animation
- Firebase integration
- User authentication

---

## 👨‍💻 Developed By

Akshay Kalwar  
Flutter Developer  
2.4+ Years Experience  

---

⭐ If you like this project, give it a star!

