part of 'pages.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  static const routeName = '/shop';

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Space.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShopItemCard(
                title: 'More players',
                description: 'Much larger game room up to 30 peoples.' +
                    ' Play with more friends',
                price: "Rp. 20.000",
                imageUrl: "morepeople_silhouette",
              ),
              ShopItemCard(
                title: 'Animal words collection',
                description:
                    'Play another exclusive words' + 'Pack : Zoo & Animals',
                price: "Rp. 8.000",
                imageUrl: "animal_silhouette.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
