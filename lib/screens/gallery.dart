import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'types.dart';
import 'table_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  String _cursor = "";
  List<Result> data = [];
  bool _dataLoaded = false;
  late final Future<List<Result>> myFuture; // avoids multiple calls to fetchJSONL
  List<Image> images = List.filled(100, const Image(image: AssetImage('images/pd.png'), fit: BoxFit.contain, alignment: Alignment.center));

  @override
  void initState() {
    super.initState();
    myFuture = fetchJSONL(100);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: FutureBuilder<List<Result>>(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data ?? [];
              if (_dataLoaded) {
                // use existing data
                return buildGallery(context, data);
              }
              _dataLoaded = true;
              // add images
              for (var res in snapshot.data ?? []) {
                images[data.indexOf(res)] = getImage(res); //fix this
              }
              return buildGallery(context, snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Widget buildGallery(BuildContext ctx, List<Result>? data) {
    return GridView.builder(
        itemCount: data?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildGalleryCard(context, index, data![index]);
        },
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

  Widget buildGalleryCard(BuildContext context, int index, Result result) {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: GridTile(
        // footer: Text(result.input ?? "", textAlign: TextAlign.center),
        child: images[index],
        // footer: ListTile(
        //     title: Text(
        //       result.input ?? "",
        //       textAlign: TextAlign.center,
        //     ),
        //     dense: true,
        //     subtitle: Row(mainAxisSize: MainAxisSize.max, children: getChips(result))),
      ),
    );
    // return Card(
    //   child: ListView(
    //     physics: const NeverScrollableScrollPhysics(),
    //     children: [
    //       images[index],
    //       const SizedBox(height: 10),
    //       ListTile(
    //           title: Text(
    //             result.input ?? "",
    //             textAlign: TextAlign.center,
    //           ),
    //           dense: true,
    //           subtitle: Row(mainAxisSize: MainAxisSize.max, children: getChips(result)))
    //     ],
    //   ),
    // );
  }

  List<Widget> getChips(Result result) {
    List<Widget> chips = [];
    for (var element in result.technologies ?? []) {
      chips.add(getChip(element));
    }
    return chips;
  }

  Image getImage(Result result) {
    if (result.screenshotBytes == null || (result.screenshotBytes ?? "").isEmpty) {
      return const Image(image: AssetImage('images/pd.png'), fit: BoxFit.contain, alignment: Alignment.center);
    } else {
      Uint8List bytesImage = const Base64Decoder().convert((result.screenshotBytes ?? ""));
      return Image.memory(bytesImage, fit: BoxFit.contain, alignment: Alignment.center);
    }
  }

  // fetchJSONL fetches the data from the server in JSONL format
  Future<List<Result>> fetchJSONL(int limit) async {
    Uri url = fetchRowUrl;
    Map<String, String> params = {
      "limit": limit.toString(),
      "cursor": _cursor,
    };
    url = url.replace(queryParameters: params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Result> data = [];
      LineSplitter.split(response.body).forEach((element) {
        if (element != "") {
          var body = json.decode(element);
          data.add(Result.fromJson(body));
        }
      });
      _cursor = response.headers['x-cursor'] ?? "";
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
