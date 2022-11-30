import 'package:flutter/material.dart';
import 'package:modul_5_tic_tac/widgets/score_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> viewElements = ['', '', '', '', '', '', '', '', ''];
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool _showGameScore = false;

  void _touched(int index) {
    setState(() {
      if (oTurn && viewElements[index] == '') {
        viewElements[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && viewElements[index] == '') {
        viewElements[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

//Row
  void _checkWinner() {
    if (viewElements[0] == viewElements[1] &&
        viewElements[0] == viewElements[2] &&
        viewElements[0] != '') {
      _showWinDialog(viewElements[0]);
    }
    if (viewElements[3] == viewElements[4] &&
        viewElements[3] == viewElements[5] &&
        viewElements[3] != '') {
      _showWinDialog(viewElements[3]);
    }
    if (viewElements[6] == viewElements[7] &&
        viewElements[6] == viewElements[8] &&
        viewElements[6] != '') {
      _showWinDialog(viewElements[6]);
    }

// Column
    if (viewElements[0] == viewElements[3] &&
        viewElements[0] == viewElements[6] &&
        viewElements[0] != '') {
      _showWinDialog(viewElements[0]);
    }
    if (viewElements[1] == viewElements[4] &&
        viewElements[1] == viewElements[7] &&
        viewElements[1] != '') {
      _showWinDialog(viewElements[1]);
    }
    if (viewElements[2] == viewElements[5] &&
        viewElements[2] == viewElements[8] &&
        viewElements[2] != '') {
      _showWinDialog(viewElements[2]);
    }

// Diagonal
    if (viewElements[0] == viewElements[4] &&
        viewElements[0] == viewElements[8] &&
        viewElements[0] != '') {
      _showWinDialog(viewElements[0]);
    }
    if (viewElements[2] == viewElements[4] &&
        viewElements[2] == viewElements[6] &&
        viewElements[2] != '') {
      _showWinDialog(viewElements[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              TextButton(
                child: Text("Start the gamen"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Dialog"),
            actions: [
              TextButton(
                child: Text("Start the game"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        viewElements[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        viewElements[i] = '';
      }
    });
    filledBoxes = 0;
  }

  Widget _showPortriatItem(xScore, oScore) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          ScoreWidget(xScore: xScore, oScore: oScore),
          Container(
            child: Expanded(
              flex: 4,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      _touched(index);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Center(
                        child: Text(
                          viewElements[index],
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 9,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _clearScoreBoard,
                  child: Text('New Game'),
                ),
                ElevatedButton(
                    onPressed: _clearBoard, child: Text('Reset Game'))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _showLandscapeItem() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Score'),
              Switch.adaptive(
                  value: _showGameScore,
                  onChanged: (value) {
                    setState(() {
                      _showGameScore = value;
                    });
                  })
            ],
          ),
          _showGameScore
              ? ScoreWidget(xScore: xScore, oScore: oScore)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _clearScoreBoard,
                          child: Text('New Game'),
                        ),
                        ElevatedButton(
                            onPressed: _clearBoard, child: Text('Reset Game'))
                      ],
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              _touched(index);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber),
                              ),
                              child: Center(
                                child: Text(
                                  viewElements[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Color.fromRGBO(108, 157, 158, 1),
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
        ),
        centerTitle: true,
      ),
      body: Container(
          child: isLandscape
              ? _showLandscapeItem()
              : _showPortriatItem(xScore, oScore)),
    );
  }
}
