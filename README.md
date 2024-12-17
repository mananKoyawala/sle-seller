# SLE Seller Flutter Application

**Seamless Linkage for Enterprise (SLE)** is my final year project, where I worked as the **backend developer** and also contributed to the app development using Flutter. The purpose of this project is to provide a **platform for B2B businesses**, enabling sellers to easily list their products and manage their profiles. This repository contains the code for the **SLE Seller** application, a part of the complete SLE system.

---

## ✨ Introduction

The **SLE Seller Application** is designed for sellers to register and manage their products seamlessly. It focuses on creating a user-friendly interface to list, update, and delete products, along with additional features for profile management. The app allows sellers to connect with buyers in an efficient and straightforward way.

### 🛠 Key Features

1. **Authentication**:

   - Sign up with email and password.
   - Login functionality.
   - Reset password for account recovery.

2. **Product Management**:

   - List all products.
   - Add new products.
   - Update existing product details.
   - Delete products.

3. **Seller Profile**:

   - View and edit profile details.
   - Navigate to static pages like _About Us_ and _Terms and Conditions_.
   - Logout functionality.

4. **SLE Buyer and Backend**:  
   This app works in conjunction with the **SLE Buyer Application** and the **SLE Backend**.
   - [SLE Buyer](#sle-buyer)
   - [SLE Backend](#sle-backend)

---

## 🔧 Technologies Used

- **Flutter** for front-end development.
- **Firebase** for authentication and backend integration.

---

## 🖥️ How to Run the App

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/sle-seller.git
   cd sle-seller
   ```
2. Install the dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## 📂 Directory Structure

```bash
   .
   ├── lib
   │   ├── screens          # Contains all app screens
   │   ├── models           # Data models for the app
   │   ├── providers        # State management using Riverpod
   │   ├── helpers          # Utility functions and APIs
   │   └── widgets          # Reusable UI components
   ├── assets               # Static assets like images and icons
   ├── pubspec.yaml         # Dependencies and app configuration
   └── README.md            # Project documentation
```

## 📱 SLE Buyer Application

- The SLE Buyer Application is the counterpart of this seller app, designed specifically for buyers to browse and purchase products. Check it out here:
  👉 [SLE Buyer Repository]()

## 💻 SLE Backend

- The SLE Backend handles the core functionality of the application, such as authentication, product management, and database operations. Explore it here:
  👉 [SLE Backend Repository]()

## 🛠 Technical Details

The SLE Seller Application leverages the following key technologies:

- Riverpod: Used for state management to ensure a reactive and efficient app architecture.
- HTTP: Used for backend integration to handle API requests and responses.
- connectivity_plus: Used to check network connectivity and provide a seamless offline/online experience.

## 📂 APK Download

- To download and test the seller app, you can use the APK file available in the output folder in the root directory:
  👉 [Download APK](output/sle_seller.apk)

## 🧪 Test Account

You can use the following test account credentials to explore the app's functionality:

- Email: thetestaccount@gmail.com
- Password: Test@123

## 📜 [LICENSE](LICENSE)
