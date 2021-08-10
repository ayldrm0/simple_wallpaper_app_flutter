import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

import '../widgets/custom_stack.dart';

class CustomSheet extends StatefulWidget {
  final data;
  final index;

  const CustomSheet({this.data, this.index});

  @override
  _CustomSheetState createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  _setWallpaper(String url) async {
    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var cIndex = widget.index;
    // = ModalRoute.of(context).settings.arguments;
    return Container(
      height: mediaQuery.size.height * 3 / 4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomStack(
              cIndex,
              widget.data,
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  _setWallpaper(widget.data.getAlbum.photos[cIndex].url),
              icon: Icon(Icons.wallpaper),
              label: Text("Set as Wallpaper"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upload By",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    widget.data.getAlbum.photos[cIndex].author,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
