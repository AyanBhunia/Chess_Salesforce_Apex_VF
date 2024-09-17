# Chess - Salesforce Apex and Visualforce Implementation

This project is a Salesforce-based Chess game developed using **Apex**, **Visualforce Pages**, and **JavaScript**. It includes core chess functionalities such as rendering chess pieces, validating moves, and keeping track of game states, all within the Salesforce platform. The app leverages Salesforce's robust capabilities to create an interactive chessboard while allowing communication between different components through Visualforce remoting and Apex classes.

## Features

- **Full Chess Gameplay**: Implements all standard chess rules and piece movements.
- **Dynamic Chessboard Rendering**: The chessboard dynamically renders using Visualforce and JavaScript, providing an interactive UI for players.
- **Move Validation**: Validates the legality of moves in real-time, ensuring players adhere to chess rules.
- **Game State Sharing**: Allows sharing the game state using FEN (Forsyth–Edwards Notation) and sending it to other systems via WebSockets.
- **Apex and SOQL Integration**: Uses Salesforce's server-side logic for handling chess data, SOQL for querying records, and efficient data management.
- **Responsive UI**: Built with user experience in mind, featuring smooth transitions and responsive design.

## Try

You can try the game directly, without any login or setup, by visiting this link:

[Play Chess on Salesforce](https://dqy00000brzl7map-dev-ed.develop.my.salesforce-sites.com/Chess)

## Installation

To install this package in your Salesforce environment, use the link below:

[Install the Chess App](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tdM0000004RRR&isdtp=p1)

After installing, search for **"Chess"** in the App Launcher. Open the Chess app and click the **"Open in New Window"** button to start playing.

## How to Play

1. After installation, navigate to the **Chess** app in your Salesforce org.
2. The chessboard will render, showing all pieces in their default starting positions.
3. Play by clicking on a piece and selecting the desired destination. The app will validate the move and update the board accordingly.

## Project Structure

- **Apex Classes**: Handles server-side logic, including move validation and game state management.
- **Visualforce Pages**: Renders the UI for the chessboard and other components.
- **JavaScript**: Manages the front-end interactivity, such as piece movement and drag-and-drop functionality.
- **SOQL Queries**: Used to retrieve and update game-related records in Salesforce.

## Technologies Used

- **Salesforce Apex**: For business logic and server-side processes.
- **Visualforce**: To create custom UI components.
- **JavaScript**: For client-side interactivity.
- **SOQL**: For querying and managing Salesforce data.

## Developer Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/AyanBhunia/Chess_Salesforce_Apex_VF.git
