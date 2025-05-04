import 'dart:io';

void main() {
  // Initialize the board
  List<String> board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
  String currentPlayer = 'X';
  bool gameEnded = false;

  // Game loop
  while (!gameEnded) {
    printBoard(board);
    print("\nPlayer $currentPlayer's turn. Enter position (1-9): ");
    int position = int.parse(stdin.readLineSync()!);

    // Check for valid move
    if (position < 1 || position > 9 || board[position - 1] != ' ') {
      print("Invalid move! Try again.");
      continue;
    }

    // Mark the board with the player's move
    board[position - 1] = currentPlayer;

    // Check if the current player wins
    if (checkWin(board, currentPlayer)) {
      printBoard(board);
      print("Player $currentPlayer wins!");
      gameEnded = true;
    } else if (board.every((element) => element != ' ')) {
      printBoard(board);
      print("It's a draw!");
      gameEnded = true;
    } else {
      // Switch player
      currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    }
  }
}

void printBoard(List<String> board) {
  print('\n${board[0]} | ${board[1]} | ${board[2]}');
  print('---------');
  print('${board[3]} | ${board[4]} | ${board[5]}');
  print('---------');
  print('${board[6]} | ${board[7]} | ${board[8]}');
}

bool checkWin(List<String> board, String player) {
  // Define win conditions (rows, columns, diagonals)
  List<List<int>> winConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  // Check each win condition
  for (var condition in winConditions) {
    if (board[condition[0]] == player && board[condition[1]] == player && board[condition[2]] == player) {
      return true;
    }
  }
  return false;
}
