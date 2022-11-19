import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedInActive();
  }

  Future saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isActiveLogin', isLoggedIn);
    //print(prefs.getBool('isActiveLogin'));
  }

  Future isLoggedInActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isActiveLogin') != null) {
      if (prefs.getBool('isActiveLogin') == true) {
        Navigator.pushNamed(context, '/dash');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
        hintText: 'Introduce el usuario',
        label: Text('Correo Electrónico'),
      ),
    );

    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Introduce el password',
        label: Text('Contraseña'),
      ),
    );

    CheckboxListTile chkRemember = CheckboxListTile(
      value: isLoggedIn,
      title: const Text('Recordar credenciales'),
      onChanged: (value) {
        setState(() {
          isLoggedIn = value as bool;
        });
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                'assets/mario_logo.png',
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 20,
              ),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 15,
                  ),
                  txtPwd,
                  SizedBox(
                    height: 15,
                  ),
                  chkRemember,
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 20,
              child: GestureDetector(
                onTap: () async {
                  saveCredentials();
                  Navigator.pushNamed(context, '/dash');
                },
                child: Image.asset('assets/bloque.png',
                    height: MediaQuery.of(context).size.width / 5),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 50,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(children: [
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.facebook,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.github,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.google,
                    onPressed: () {},
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
