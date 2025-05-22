Vehicle Repair Booking App

A Flutter application that allows users to book vehicle repair services. This app simulates a basic customer-side experience for booking vehicle repair appointments.

Features

Login Screen

Email and password authentication (hardcoded credentials)

Form validation

User session management

Home Screen:

List of nearby repair stations

Station details including name, distance, rating, and type

User-friendly UI with station cards

Booking Screen:
Vehicle type selection

Date and time picker

Description input field

Appointment booking with loading indicator and success message

Installation

Prerequisites

Flutter SDK (3.0.0 or higher)

Dart SDK (3.0.0 or higher)

Android Studio / VS Code

Steps to Run:

Clone the repository
bash
git clone https://github.com/yourusername/vehicle_repair_booking.git

cd vehicle_repair_booking

Install dependencies
bash
flutter pub get
Run the app
bash
flutter run
Usage
Login
Use the following credentials:
Email: intern@balancee.com
Password: Intern123#
Browse Repair Stations
View the list of available repair stations
See details like distance, rating, and station type
Book an Appointment
Select a station
Choose vehicle type, date, and time
Add a description of your repair needs
Submit booking
Project Structure

lib/

 main.dart                # Entry point of the application

screens/

── login_screen.dart    # User authentication

── home_screen.dart     # List of repair stations

── booking_screen.dart  # Appointment booking form

 models/

── station.dart         # Station data model

── user.dart            # User data model

 services/

── auth_service.dart    # Authentication logic

 widgets/
    station_card_widget.dart    # Reusable station list item
    custom_button.dart   # Reusable button component
Dependencies
shared_preferences: For storing user session data

intl: For date and time formatting

Demo

Show Image

Code Highlights

Clean Architecture: Separation of UI, business logic, and data layers

State Management: Using StatefulWidget for local state management

Reusable Components: Custom widgets for better code organization

Form Validation: Input validation for better user experience



