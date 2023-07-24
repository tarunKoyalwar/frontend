import 'package:flutter/material.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: buildGallery(context),
    );
  }

  Widget buildGallery(BuildContext ctx) {
    return GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => buildGalleryCard('Image ${index + 1}'),
        // itemBuilder: (context, index) => bui,
        gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 600, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.25));
  }

  Widget getChip(String value) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        height: 30,
        child: Chip(
          label: Text(value),
        ),
      ),
    );
  }

  Widget buildGalleryCard(String value) {
    return Card(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Image(
            image: AssetImage('images/pd.png'),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 10),
          ListTile(
              title: Text(
                value,
                textAlign: TextAlign.center,
              ),
              dense: true,
              subtitle: Row(mainAxisSize: MainAxisSize.max, children: [getChip("React"), getChip("Flutter")]))
        ],
      ),
    );
  }
}
