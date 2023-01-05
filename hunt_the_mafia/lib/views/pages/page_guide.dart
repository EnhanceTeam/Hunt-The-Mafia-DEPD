part of 'pages.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  static const routeName = '/guide';

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Space.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General Rules',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Minimum Player : 3',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Gameplay',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Text(
                "In this game there are 4 roles, namely Civilians, Mr. Black, Mr. White and the Mafia. Each player will get a word and a role that is determined randomly by the system. After all the players get a word, they start describing each word in order, they can choose to discuss to eliminate who they suspect or continue to describe each other's word again. Civilians and Mr. Black is said to win if the entire mafia is eliminated and Mr. White failed to guess the word that belonged to civilians. While the mafia and Mr. White would win if they managed to keep less than one civilians and Mr. White managed to guess the word that belonged to civilians.",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Roles',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              GuideCard(
                name: 'Civilian',
                condition: 'All Mafias Knocked Up',
                description:
                    "Civilian's duty is describing the words they get but may not directly mention the words they get. Civilians are also trying to guess which of the players is Mr. White and the Mafia.",
                image: "https://source.unsplash.com/random/800x600?house",
              ),
              GuideCard(
               name: 'Mr. Black',
                condition: 'Civilians win',
                description:
                    "Mr. Black's duty is to side with civilians where this role gets both words at once but Mr. Black must be able to guess which of them is Mr. White and the mafia.",
                image: "https://source.unsplash.com/random/800x600?house",
              ),
              GuideCard(
                name: 'Mr. White',
                condition: 'When voted, guess the Civilians’ word',
                description:
                    "Mr. White doesn't get any words, so it's his job to go undercover and try to guess the word Civilians got.",
                image: "https://source.unsplash.com/random/800x600?house",
              ),
              GuideCard(
                name: 'Mafia',
                condition: 'All Civilians Knocked Up',
                description:
                    "The Mafia's job is to go undercover and try to incite everyone to eliminate Civilians.",
                image: "https://source.unsplash.com/random/800x600?house",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
