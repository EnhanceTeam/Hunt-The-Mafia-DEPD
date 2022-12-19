part of 'widgets.dart';

class WaitingRoomPlayerItemCard extends StatelessWidget {
  const WaitingRoomPlayerItemCard({
    super.key,
    required this.playerName,
    this.isHost = false,
  });

  final String playerName;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return FilledCard(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Space.medium,
          vertical: Space.small,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Text(
            playerName[0].toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        title: Text(playerName),
        trailing: isHost
            ? SvgPicture.asset(
                '${Const.svgPath}/host_crown.svg',
                height: 32,
              )
            : null,
      ),
    );
  }
}
