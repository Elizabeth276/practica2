import 'package:clases/provider/theme_provider.dart';
import 'package:clases/settings/styles_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                tema.setthemData(temaDia());
              },
              icon: Icon(Icons.brightness_1),
              label: Text('Tema de día'),
            ),
            TextButton.icon(
              onPressed: () {
                tema.setthemData(temaNoche());
              },
              icon: Icon(Icons.dark_mode),
              label: Text('Tema de noche'),
            ),
            TextButton.icon(
              onPressed: () {
                tema.setthemData(temaCalido());
              },
              icon: Icon(Icons.hot_tub_sharp),
              label: Text('Tema calido'),
            ),
          ],
        ),
      ),
    );
  }
}
