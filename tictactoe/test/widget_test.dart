import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;

  void handleTap(int index) {
    if (board[index] != '') return;

    setState(() {
      board[index] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
    });
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => buildCell(index),
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
