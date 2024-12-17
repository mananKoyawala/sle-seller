# SLE Seller Flutter Application

**Seamless Linkage for Enterprise (SLE)** is my final year project, where I worked as the **backend developer**.

To further showcase my skills, I implemented my own backend using **Flutter** for the seller application, demonstrating the ability to integrate backend functionality within the app. The purpose of this project is to provide a platform for **B2B businesses**, enabling sellers to easily list their products, manage their profiles, and interact seamlessly with buyers.

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
├── android               # Android-specific files
├── ios                   # iOS-specific files
├── assets                # Static assets like images and icons
├── lib                   # Main application code
│   ├── api               # Common HTTP functions (GET, POST, etc.)
│   ├── connection        # Connectivity-related utilities (e.g., connectivity_plus)
│   ├── helper            # Middleware between API and function calls
│   ├── models            # Data models
│   ├── packages          # Custom reusable components (e.g., text, text fields, buttons)
│   ├── providers         # State management logic (e.g., Riverpod providers)
│   ├── screens           # All application screens (e.g., Home, Profile, etc.)
│   ├── service           # App-level services like NavigatorKey
│   ├── utils             # Utility functions and reusable widgets
│   │   ├── widgets       # Folder for reusable widgets (e.g., NoInternet, loaders)
│   │   └── constants.dart # App-wide constants (e.g., colors, text styles)
├── output                # Contains the APK file for distribution
├── pubspec.yaml          # Dependencies and app configuration
└── README.md             # Project documentation

```

## 📱 SLE Buyer Application

- The SLE Buyer Application is the counterpart of this seller app, designed specifically for buyers to browse and purchase products. Check it out here:
  👉 [SLE Buyer Repository](https://github.com/mananKoyawala/sle-buyer)

## 💻 SLE Backend

- The SLE Backend handles the core functionality of the application, such as authentication, product management, and database operations. Explore it here:
  👉 [SLE Backend Repository](https://github.com/Seamless-Linkage-for-Enterprises/sle-backend)

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
