part of 'widgets.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({
    super.key,
    this.title,
    this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return FilledCard(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Space.medium,
          vertical: Space.small,
        ),
        title: title == null ? null : Text(title!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (description != null) Text(description!),
          ],
        ),
      ),
    );
  }
}
