import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:image_cropper/image_cropper.dart';

class CustomSheet extends StatefulWidget {
  final data;
  final index;

  const CustomSheet({this.data, this.index});

  @override
  _CustomSheetState createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  _setWallpaper(String url, media) async {
    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    var croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio:
          CropAspectRatio(ratioX: media.size.width, ratioY: media.size.height),
      androidUiSettings: AndroidUiSettings(),
    );
    await WallpaperManager.setWallpaperFromFile(croppedFile.path, location);
  }

  @override
  Widget build(BuildContext context) {
    var photos = widget.data.getAlbum.photos;
    final mediaQuery = MediaQuery.of(context);
    var cIndex = widget.index;
    // = ModalRoute.of(context).settings.arguments;
    return Container(
      height: mediaQuery.size.height * 3 / 4,
      child: StatefulBuilder(builder: (ctx, StateSetter stateSet) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: mediaQuery.orientation == Orientation.landscape
                    ? mediaQuery.size.height * 3 / 4
                    : null,
                child: Stack(alignment: Alignment.center, children: [
                  Image.network(
                    photos[cIndex].url,
                    fit: BoxFit.contain,
                    width: mediaQuery.size.width,
                    loadingBuilder: (ctx, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  value: null,
                                ),
                              ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black45,
                        child: IconButton(
                          onPressed: () {
                            stateSet(() {
                              if (cIndex != 0) cIndex--;
                            });
                          },
                          icon: Icon(Icons.navigate_before),
                          iconSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black45,
                        child: IconButton(
                          onPressed: () {
                            stateSet(() {
                              if (cIndex != photos.length) cIndex++;
                            });
                          },
                          icon: Icon(Icons.navigate_next),
                          iconSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              OutlinedButton.icon(
                onPressed: () => _setWallpaper(photos[cIndex].url, mediaQuery),
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
                      "Uploaded By",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      photos[cIndex].author,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
