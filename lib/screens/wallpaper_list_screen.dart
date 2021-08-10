import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/custom_sheet.dart';
import '../image_provider.dart';

class WallpaperListScreen extends StatefulWidget {
  @override
  _WallpaperListScreenState createState() => _WallpaperListScreenState();
}

class _WallpaperListScreenState extends State<WallpaperListScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpapers"),
      ),
      body: FutureBuilder(
          future:
              Provider.of<ProvideImage>(context, listen: false).fetchAlbum(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<ProvideImage>(
                    builder: (ctx, albumData, _) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 21 / 14,
                            crossAxisCount:
                                mediaQuery.orientation == Orientation.portrait
                                    ? 1
                                    : 2),
                        padding: EdgeInsets.only(top: 5),
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () => showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => CustomSheet(
                                data: albumData,
                                index: index,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Card(
                                elevation: 5,
                                child: Image.network(
                                  albumData.getAlbum.photos[index].url,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: albumData.getAlbum.photos.length,
                      );
                    },
                  );
          }),
    );
  }
}
