import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  String? path = '';
  String? name = '';
  String? email = '';
  String? phone = '';
  String? github = '';
  UserDAO? user;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtgithub = TextEditingController();
  bool? ban = false;

  @override
  void initState() {
    super.initState();
    user = UserDAO();
  }

  Future setImagen(opcion) async {
    var pickedFile;
    if (opcion == 1)
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    else if (opcion == 2)
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedFile != null ? path = pickedFile.path : path = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text('Editar perfil'),
      ),
      body: FutureBuilder(
        future: user!.getUser(1),
        builder: (BuildContext context, AsyncSnapshot<UserDAO?> snapshot) {
          if (snapshot.hasData) {
            ban = true;
            txtName.text = snapshot.data!.fullName!;
            txtEmail.text = snapshot.data!.email!;
            txtPhone.text = snapshot.data!.phone!;
            txtgithub.text = snapshot.data!.githubPage!;

            return buildFormData(
                snapshot.data!.idUser,
                snapshot.data!.photo,
                snapshot.data!.fullName,
                snapshot.data!.email,
                snapshot.data!.phone,
                snapshot.data!.githubPage);
          } else if (snapshot.hasError)
            return Center(
              child: Text('ERROR'),
            );

          ban = false;
          return buildFormData(1, path, name, email, phone, github);
        },
      ),
    );
  }

  Widget buildFormData(idUser, path, name, email, phone, github) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Hero(
                    tag: 'profile_picture',
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).backgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (path == '')
                              ? const AssetImage('assets/profile.jpg')
                              : FileImage(File(path)) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        opciones(context);
                        //final picker = new ImagePicker();
                        //var pickedFile = await picker.pickImage(
                        //  source: ImageSource.camera);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 3,
                                color: Theme.of(context).backgroundColor),
                            color: Colors.blue),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                name == '' ? 'Elizabeth Villagómez' : name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            buildTextField(
                'Nombre completo', 'Ingresa tu nombre completo', txtName),
            buildTextField('Correo electrónico', 'Ingresa tu correo', txtEmail),
            buildTextField('Teléfono', 'Ingresa tu teléfono', txtPhone),
            buildTextField('Github', 'Página de github', txtgithub),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).backgroundColor),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (ban == true) {
                      user!.actualizar({
                        'idUser': idUser,
                        'fullName': txtName.text,
                        'photo': path,
                        'email': txtEmail.text,
                        'phone': txtPhone.text,
                        'githubPage': txtgithub.text
                      }, 'tblUser').then((value) {
                        const snackBar = SnackBar(
                          content:
                              Text('Información actualizada correctamente!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else if (ban == false) {
                      user!.insertar({
                        'idUser': idUser,
                        'fullName': txtName.text,
                        'photo': path,
                        'email': txtEmail.text,
                        'phone': txtPhone.text,
                        'githubPage': txtgithub.text
                      }, 'tblUser').then((value) {
                        const snackBar = SnackBar(
                          content:
                              Text('Información registrada correctamente!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.14),
                    backgroundColor: Theme.of(context).backgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    'GUARDAR',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            focusColor: Colors.red,
            labelText: labelText,
            hintText: placeholder,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setImagen(1);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Tomar fotografía',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setImagen(2);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Abrir galería',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
