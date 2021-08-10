import 'package:flutter/material.dart';

class CustomStack extends StatefulWidget {
  final index;
  final data;

  CustomStack(this.index, this.data);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomStack> {
  @override
  Widget build(BuildContext context) {
    var photos = widget.data.getAlbum.photos;
    var cIndex = widget.index;
    var mediaQuery = MediaQuery.of(context);
    return StatefulBuilder(builder: (ctx, StateSetter stateSet) {
      return Container(
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
      );
    });
  }
}
