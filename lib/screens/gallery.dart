import 'package:flutter/material.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});
  static const int _count = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: buildGallery(context),
    );
  }

  // calculateHeight calculates the height of image based on available width
  // to preserve the aspect ratio of the image.
  int calculateHeight(int inputWidth) {
    const int originalWidth = 1920;
    const int originalHeight = 1080;

    int calculatedHeight = ((inputWidth / originalWidth) * originalHeight).round();
    return calculatedHeight;
  }

  // get min width of image based on available width for the widget
  int getMinWidth(int availableWidth) {
    const int minWidth = 200;
    int calculatedWidth = (availableWidth / _count).round();
    if (calculatedWidth < minWidth) {
      calculatedWidth = minWidth;
    }
    return calculatedWidth;
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
      padding: EdgeInsets.only(left: 5, right: 5),
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
          SizedBox(height: 10),
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

    // return Card(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       const Image(
    //         image: AssetImage('images/pd.png'),
    //         fit: BoxFit.contain,
    //         alignment: Alignment.center,
    //       ),
    //       Spacer(),
    //       Text(
    //         value,
    //         textAlign: TextAlign.center,
    //       ),
    //     ],
    //   ),
    // );
  }

  // Widget buidImageCard(int index, String value, int maxheight) {
  //   // var imageHeight = (maxheight < 200) ? 200 : maxheight;

  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Card(
  //         margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: GridTile(
  //             child: Image.asset(
  //           'images/pd.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.center,
  //         )),
  //       ),
  //       Text(
  //         value,
  //         textAlign: TextAlign.center,
  //       ),
  //     ],
  //   );
  // }
}
