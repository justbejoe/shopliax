# shopliax_todo

## Getting Started

This app was built using Flutter and dart
State management technique used is Riverpod
GoRouter was used for Navigation
Shared Preference for local storage

App consist of 4 major Pages
1- Landing Screens
2- Todolist Page/Homepage
3- Api data Screen
4- Create todo Screen

If you launch/open the application, it takes you to the landing page
Click on Let's start and it will tak you to the homepage
Bottom navigation Bar takes you to the selected screens

# Hompepage: is a List page of predefined todo items,
You can edit the todo item by tapping  on the edit icon,
slide  left or right on each item to delete/remove it.

# Create todo Screen: has a textfield that must be filled in order
to create a todo. If  successfully created it will navigate back to the homepage and you see the updated list.
Else it will give you an error if unsuccessful.

# Api data screen: Displays a list of data fetched from the provided endpoint "https://jsonplaceholder.typicode.com/photos"
it fetches  the data and saves the first 20 items to a local storage.
saved items can be viewed when offline. 
