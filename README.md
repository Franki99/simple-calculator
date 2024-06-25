# Simple Calculator App

## Overview

This project is a simple calculator app built using Flutter and Firebase Authentication. The app includes a basic arithmetic calculator and a navigation drawer with options to view the Home, About pages, and to log out. The app features a clean and intuitive user interface with customizable appearance for active and inactive tabs in the navigation menu.

![Calculator App](<./lib/images/Calculator-Page%20(2).jpg>)

## Features

- Basic arithmetic operations: addition, subtraction, multiplication, and division
- Clear button to reset the calculator
- Responsive design for various screen sizes
- Firebase Authentication for user login and logout
- Navigation drawer with active tab highlighting

![Navigation Drawer](<./lib/images/Menu (1).jpg>), ![Login Page](<./lib/images/Login-Page%20(1).jpg>), ![Signup Page](<./lib/images/signup-Page%20(1).jpg>)

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase](https://firebase.google.com/) project setup

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/simple-calculator.git
```

2. Navigate to the project directory:

```bash
cd simple-calculator
```

3. Install the required dependencies:

```bash
flutter pub get
```

4. Set up Firebase for your project:

- Create a Firebase project in the Firebase Console
- Add an Android and/or iOS app to your Firebase project
- Follow the instructions to download the google-services.json (for Android) or GoogleService-Info.plist (for iOS) files and place them in the appropriate directory in your Flutter project

5. Run the app:

```bash
flutter run
```

## Project Structure

- lib/main.dart: Entry point of the application

- lib/home_page.dart: Contains the HomePage widget with the navigation drawer and calculator body
- lib/navigation_drawer.dart: Contains the NavigationDrawer widget and the signUserOut method
- lib/calculator_body.dart: Contains the CalculatorBody widget and the CalculatorButton widget

## Code Explanation

### HomePage

The HomePage widget is a StatefulWidget that maintains the state of the active tab and includes the navigation drawer and calculator body.

### NavigationDrawer

The NavigationDrawer widget displays the navigation menu with options for Home, About, and Logout. It highlights the active tab in blue with bold text.

### CalculatorBody

The CalculatorBody widget contains the calculator display and buttons. It handles button presses to perform arithmetic operations and update the display.

### CalculatorButton

The CalculatorButton widget represents a calculator button with customizable text, text color, and background color. It uses an ElevatedButton styled as a circular button.

## Customization

To customize the appearance of active and inactive tabs in the navigation drawer, modify the \_buildDrawerItem method in NavigationDrawer:

```dart
Widget _buildDrawerItem({
  required IconData icon,
  required String text,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isActive ? Colors.blue : Colors.black,
    ),
    title: Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.blue : Colors.black,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: onTap,
  );
}
```

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

### Acknowledgements

- [Flutter](https://flutter.dev/) for providing an excellent framework for building cross-platform applications
- [Firebase](https://firebase.google.com/) for backend services and authentication
