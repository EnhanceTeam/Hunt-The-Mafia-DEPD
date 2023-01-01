part of 'widgets.dart';

class GuideCard extends StatelessWidget {
  GuideCard({
    super.key,
    this.name,
    this.condition,
    this.description,
    this.image,
  });

  final String? name;
  final String? condition;
  final String? description;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return FilledCard(
      child: ListTile(
          tileColor: const Color(0xFFFFB800),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Space.medium,
            vertical: Space.small,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        if (image != null)
                          (CircleAvatar(
                            backgroundImage: NetworkImage((image!)),
                            radius: 35,
                          ))
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 5.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (name != null)
                                Text(name!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 5.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Win Condition",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          if (condition != null)
                            (Text(condition!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              ),
              if (description != null)
                Text(description!,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    textAlign: TextAlign.justify),
            ],
          )),
    );
  }
}
