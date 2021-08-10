import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/wallpaper_list_screen.dart';

import 'image_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProvideImage>(
          create: (ctx) => ProvideImage(),
        ),
      ],
      child: MaterialApp(
        title: 'Wallpaper App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: TextTheme(
              headline5: TextStyle(color: Colors.grey[600]),
              headline6: TextStyle(color: Colors.grey[600])),
        ),
        home: WallpaperListScreen(),
      ),
    );
  }
}
