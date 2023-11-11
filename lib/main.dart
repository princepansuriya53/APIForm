import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'getprofile.dart';
import 'forgetmail.dart';
import 'dart:convert';
import 'singin.dart';

final storage = GetStorage();
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "From Api",
      home: storage.read("login") == null ? login() : profile(),
    );
  }
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String email = '';
  String pwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                    decoration: const InputDecoration(
                      labelText: "Mail",
                      hintText: "Enter the emailId",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => pwd = value,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter the Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => singin()),
                            ),
                        child: const Text('Register')),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return mailforget(email: email);
                              },
                            ),
                          ),
                      child: const Text('Forgetpassword'))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    registerfun();
                  },
                  child: const Text('Login')),
            ],
          ),
        ));
  }

  void registerfun() async {
    http.Response res = await Authorepo.registerapi(email: email, pwd: pwd);
    print(
      "${"${registerurl.baseurl}?action=signin&email=$email"}&pwd=$pwd",
    );
    if (res != null) {
      var response = jsonDecode(res.body);
      var respinse1 = jsonDecode(res.body)["data"];
      if (response["message"] == "Successfully Login") {
        setState(() {
          storage.write("login", response);
          storage.write('userdata', respinse1[0]['Users_id']);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Text("${response["message"]}"),
              ),
            )
            .closed
            .then(
              (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profile(),
                  )),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response["message"]}"),
          ),
        );
      }
    }
  }
}

class registerurl {
  static String baseurl = 'https://vstechno.co.in/news/api/user.php';
}

class Authorepo {
  static Future registerapi({
    required email,
    required pwd,
  }) async {
    return await get(
      Uri.parse(
        "${registerurl.baseurl}?action=signin&email=" + email + "&pwd=" + pwd,
      ),
    );
  }
}
