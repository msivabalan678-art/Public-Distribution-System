# 🇮🇳 Smart PDS – Tamil Nadu

### A Smart Digital Platform for Public Distribution System Services

Smart PDS is a Flutter-based mobile application prototype designed to simplify access to Public Distribution System (PDS) services in Tamil Nadu. The application aims to provide beneficiaries with a convenient platform to manage their ration-related information, check commodity availability, view purchase history, and receive important updates.

---

## 1. Project Description

The Public Distribution System (PDS) plays an important role in providing essential commodities to eligible families through ration shops.

Smart PDS aims to digitize and simplify beneficiary interactions by bringing important ration-related features into a single mobile application.

The application uses Flutter for the frontend and Firebase Cloud Firestore for storing beneficiary registration information.

## 2. Problem Statement

Beneficiaries may face difficulties in accessing ration-related information, tracking monthly purchases, checking commodity availability, and managing their beneficiary details.

Traditional processes can require beneficiaries to visit ration shops or depend on manual information.

**Proposed Solution:**

Smart PDS provides a centralized digital platform where beneficiaries can access important ration-related information through a simple and user-friendly interface.

## 3. Key Features

### User Registration
- Register using personal information.
- Enter ration card details.
- Select ration card category.
- Select district and taluk.
- Submit registration information.

### OTP Verification
- OTP verification screen.
- Designed for mobile number verification.
- Real SMS-based authentication is planned for a future version.

### Dashboard
- Centralized beneficiary dashboard.
- Quick access to application modules.
- Ration-related information overview.

### Stock Availability
- View essential commodity information.
- Check displayed stock details.

### Purchase History
- View previous purchase information.
- Track ration-related transaction details.

### Alerts and Notifications
- Dedicated alerts section.
- Designed for important ration-related updates.

### User Profile
- View registered beneficiary information.
- Access profile details.

## 4. Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Application programming language |
| Firebase Core | Firebase initialization |
| Cloud Firestore | Cloud database |
| Visual Studio Code | Development environment |
| Git | Version control |
| GitHub | Source code management |

## 5. Application Screenshots

Screenshots of the application will be added here.

| Screen | Preview |
|---|---|
| Splash Screen | Coming Soon |
| Registration Screen | Coming Soon |
| OTP Verification | Coming Soon |
| Dashboard | Coming Soon |
| Stock Availability | Coming Soon |
| Purchase History | Coming Soon |
| Profile | Coming Soon |

## 6. Firebase Integration

Firebase is integrated into the application for backend services and cloud data storage.

### Firebase Services Used

- Firebase Core
- Cloud Firestore

### Database Structure

The application uses Cloud Firestore to organize beneficiary information.

**users Collection**

Stores beneficiary registration information.

Example fields:
- name
- mobile
- city
- district
- userType
- isActive

**ration_cards Collection**

Stores ration card-related information.

Example fields:
- rationCardNumber
- cardType
- holderName
- district
- userId

The `userId` field is used to associate a ration card record with its corresponding user.

> Note: The current Firebase integration stores application registration data. Official Tamil Nadu government PDS database integration has not been implemented.

## 7. Installation and Setup

Follow these steps to run the project locally.

### Prerequisites

Install the following:

- Flutter SDK
- Dart SDK
- Visual Studio Code
- Git
- Firebase project

### Step 1: Clone the Repository

```bash
git clone https://github.com/msivabalan678-art/Public-Distribution-System.git
```

### Step 2: Navigate to the Project

```bash
cd Public-Distribution-System
```

### Step 3: Install Dependencies

```bash
flutter pub get
```

### Step 4: Configure Firebase

Configure your own Firebase project using FlutterFire CLI.

```bash
dart pub global activate flutterfire_cli
```

Then run:

```bash
flutterfire configure
```

Select the platforms you want to support.

Make sure Firebase Authentication and Firestore security rules are configured appropriately before using real beneficiary information.

### Step 5: Run the Application

```bash
flutter run
```

To run the application in Chrome:

```bash
flutter run -d chrome
```

## 8. Future Enhancements

The following features are planned for future development:

- Real SMS OTP authentication using Firebase Authentication.
- Dynamic beneficiary dashboard using Firestore.
- Live ration commodity stock updates.
- Monthly entitlement tracking.
- Purchase transaction history.
- Push notifications for important updates.
- Secure authentication and role-based access.
- Integration with authorized government PDS services, subject to official API access and approval.

## 9. Project Status

**Current Status: Prototype Development**

| Module | Status |
|---|---|
| Flutter UI | Developed |
| User Registration | Integrated with Firestore |
| Firebase Connection | Configured |
| OTP Verification | Demo implementation |
| Dynamic Dashboard | Future enhancement |
| Live Stock Updates | Future enhancement |
| Government PDS Integration | Future enhancement |

## 10. Developer

**Developed by:** Sivabalan M

**Project:** Smart PDS – Tamil Nadu

**GitHub Repository:**  
https://github.com/msivabalan678-art/Public-Distribution-System

---

### Disclaimer

This project is an independent software development prototype created for learning and demonstration purposes. It is not an official application of the Government of Tamil Nadu or the Government of India. It is not currently connected to official government PDS databases or services.
