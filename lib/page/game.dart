import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);
  final String title = 'Game';

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  ChessBoardController controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            child: ChessBoard(controller: controller),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
                onPressed: () => setState(() {
                      controller.resetBoard();
                    }),
                icon: const Icon(Icons.refresh)),
          )
        ],
      ),
    );
  }
}
