part of 'widgets.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({
    super.key,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  });

  final String? title;
  final String? description;
  final String? price;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return FilledCard(
      child: ListTile(
        tileColor: Const.baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Space.medium,
          vertical: Space.small,
        ),
        title: title == null
            ? null
            : Text(
                title!,
              ),
        subtitle: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (description != null)
                    Text(
                      description!,
                      maxLines: 2,
                    ),
                  if (price != null)
                    Text(
                      price!,
                      maxLines: 2,
                      style: TextStyle(color: Const.accentColor),
                    ),
                ],
              ),
            ),
            // Flexible(
            //   flex: 2,
            //   child: Container(
            //     width: 70,
            //     height: 70,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.all(Radius.circular(12))),
            // child: Image.asset(
            //   imageUrl != null ? imageUrl! : "",
            // ),
            // ),
            // )
          ],
        ),
      ),
    );
  }
}
