part of 'pages.dart';

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({super.key});

  static const routeName = '/game-room';

  @override
  State<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(Space.large),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Space.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Room Code',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedSpacer.vertical(space: Space.medium),
                  Text(
                    'N1310',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              SizedSpacer.vertical(space: Space.medium),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Space.small),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const WaitingRoomPlayerItemCard(
                          playerName: 'Daniel',
                          isHost: true,
                        ),
                        SizedSpacer.vertical(space: Space.medium),
                        Text(
                          'Waiting for players...',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedSpacer.vertical(space: Space.medium),
              FilledButton(
                label: 'Start Game',
                maxSize: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
