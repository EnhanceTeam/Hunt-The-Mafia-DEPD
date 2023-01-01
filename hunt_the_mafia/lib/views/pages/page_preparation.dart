part of 'pages.dart';

class PreparationPage extends StatefulWidget {
  const PreparationPage({Key? key, required this.roomId}) : super(key: key);

  static const String routeName = "/preparation";

  final String roomId;

  @override
  State<PreparationPage> createState() => _PreparationPageState();
}

class _PreparationPageState extends State<PreparationPage> {
  int _civilianCount = 2;
  int _mafiaCount = 1;
  int _mrWhiteCount = 0;
  int _mrBlackCount = 0;
  late int _totalCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(Space.large),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedSpacer.vertical(space: Space.medium),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Room Code',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedSpacer.vertical(space: Space.medium),
                    Text(
                      widget.roomId,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              Center(
                child: Column(
                  children: [
                    const Text('Civilian',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_civilianCount > 2) {
                                _civilianCount--;
                              }
                              if (_mafiaCount > (_civilianCount - 3)) {
                                _mafiaCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text('$_civilianCount',
                            style: const TextStyle(fontSize: 24.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              _totalCount = _civilianCount +
                                  _mafiaCount +
                                  _mrWhiteCount +
                                  _mrBlackCount;
                              if (_totalCount < 20) {
                                _civilianCount++;
                              }
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              Center(
                child: Column(
                  children: [
                    const Text('Mafia',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_mafiaCount > 1) {
                                _mafiaCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text('$_mafiaCount',
                            style: const TextStyle(fontSize: 24.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              _totalCount = _civilianCount +
                                  _mafiaCount +
                                  _mrWhiteCount +
                                  _mrBlackCount;
                              if (_mafiaCount < (_civilianCount - 3) && _totalCount < 20) {
                                _mafiaCount++;
                              }
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              Center(
                child: Column(
                  children: [
                    const Text('Mr. White',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_mrWhiteCount > 0) {
                                _mrWhiteCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text('$_mrWhiteCount',
                            style: const TextStyle(fontSize: 24.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              _totalCount = _civilianCount +
                                  _mafiaCount +
                                  _mrWhiteCount +
                                  _mrBlackCount;
                              if (_mrWhiteCount < 1 && _totalCount < 20) {
                                _mrWhiteCount++;
                              }
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              Center(
                child: Column(
                  children: [
                    const Text('Mr. Black',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_mrBlackCount > 0) {
                                _mrBlackCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text('$_mrBlackCount',
                            style: const TextStyle(fontSize: 24.0)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(24, 48),
                          ),
                          onPressed: () {
                            setState(() {
                              _totalCount = _civilianCount +
                                  _mafiaCount +
                                  _mrWhiteCount +
                                  _mrBlackCount;
                              if (_mrBlackCount < 1 && _totalCount < 20) {
                                _mrBlackCount++;
                              }
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedSpacer.vertical(space: Space.large),
                    const Text(
                      'Note: Total maximum players is 20', style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              SizedSpacer.vertical(space: Space.large),
              FilledButton(
                label: 'Start Game',
                maxSize: true,
                onPressed: () {
                  RoleCountService.addRole(
                      widget.roomId, "civilian_count", _civilianCount);
                  RoleCountService.addRole(
                      widget.roomId, "mafia_count", _mafiaCount);
                  RoleCountService.addRole(
                      widget.roomId, "mr_white_count", _mrWhiteCount);
                  RoleCountService.addRole(
                      widget.roomId, "mr_black_count", _mrBlackCount);

                  // todo: navigate to game lobby
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GameScreen(
                  //       roomId: widget.roomId,
                  //     ),
                  //   ),
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
