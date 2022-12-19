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
                description: 'Description',
              ),
              ShopItemCard(
                title: 'More avatars',
                description: 'Description',
              ),
              ShopItemCard(
                title: 'Dark theme',
                description: 'Description',
              ),
              ShopItemCard(
                title: 'Animal words collection',
                description: 'Description',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
