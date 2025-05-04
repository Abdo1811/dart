import 'package:flutter/material.dart'; // ❗ No space between 'package:' and 'flutter'

void main() => runApp(TicTacToeApp()); // 👈 This class is defined below

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key}); // ✅ Added key as recommended

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key}); // ✅ Added key

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
  bool gameEnded = false;

  void makeMove(int index) {
    if (board[index] == ' ' && !gameEnded) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWin()) {
          gameEnded = true;
          showResultDialog("Player $currentPlayer wins!");
        } else if (!board.contains(' ')) {
          gameEnded = true;
          showResultDialog("It's a draw!");
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  void showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }

  bool checkWin() {
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

    for (var condition in winConditions) {
      if (board[condition[0]] == currentPlayer &&
          board[condition[1]] == currentPlayer &&
          board[condition[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, ' ');
      currentPlayer = 'X';
      gameEnded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic Tac Toe")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => makeMove(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text("Reset Game"),
          ),
        ],
      ),
    );
  }
}
