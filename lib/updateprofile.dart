import 'main.dart';
import 'dart:convert';
import 'getprofile.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class uprofile extends StatefulWidget {
  @override
  State<uprofile> createState() => _uprofileState();
}

class _uprofileState extends State<uprofile> {
  String user_id = storage.read('userdata');
  String fname = '';
  String lname = '';
  String email = '';
  String mno = '';
  String addr = '';
  String city = '';
  String state = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 156, 203),
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(right: 50, left: 90, top: 20, bottom: 20),
              child: Text('Update Your Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.3),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (value) {
                  fname = value;
                },
                initialValue: storage.read('Fnamne').toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: storage.read('Lname').toString(),
                onChanged: (value) {
                  lname = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The Last name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: storage.read('id').toString(),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The Mail Address",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: storage.read('Contact').toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  mno = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The Mobile Number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: storage.read('Address').toString(),
                onChanged: (value) {
                  addr = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The  Address",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                initialValue: storage.read('city').toString(),
                onChanged: (value) {
                  city = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The City Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (value) {
                  state = value;
                },
                initialValue: storage.read('State').toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: "Enter The State Name",
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    updatefrom();
                  },
                  child: const Text('Update Data')),
            ),
          ],
        ),
      ),
    );
  }

  void updatefrom() async {
    setState(() {
      fname = fname == "" ? storage.read('Fnamne') : fname;
      print('^^^^^^^^$fname');
      lname = lname == "" ? storage.read('Lname') : lname;
      print('^^^^^^^^$lname');
      email = email == "" ? storage.read('id') : email;
      print('^^^^^^^^$email');
      mno = mno == "" ? storage.read('Contact') : mno;
      print('^^^^^^^^$mno');
      addr = addr == "" ? storage.read('Address') : addr;
      print('^^^^^^^^$addr');
      city = city == "" ? storage.read('city') : city;
      print('^^^^^^^^$city');
      state = state == "" ? storage.read('State') : state;
      print('^^^^^^^^$state');
    });
    http.Response res = await Authorepo.registerApi(
        user_id: user_id,
        fname: fname,
        lname: lname,
        email: email,
        mno: mno,
        addr: addr,
        city: city,
        state: state);
    print('${Registerurl.baseurl}?action=updprofile&user_id=' +
        user_id +
        "&fname=" +
        fname +
        "&lname=" +
        lname +
        "&email=" +
        email +
        "&mno=" +
        mno +
        "&addr=" +
        addr +
        "&city=" +
        city +
        "&state=" +
        state);
    if (res != null) {
      var response = jsonDecode(res.body);
      if (response["message"] == "Your profile Successfully updated") {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(content: Text('${response["message"]}')),
            )
            .closed
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile()),
              ),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response["message"]}')),
        );
      }
    }
  }
}

class Registerurl {
  static String baseurl = 'https://vstechno.co.in/news/api/user.php';
}

class Authorepo {
  static Future registerApi({
    required user_id,
    required fname,
    required lname,
    required email,
    required mno,
    required addr,
    required city,
    required state,
  }) async {
    return await get(Uri.parse(
        '${Registerurl.baseurl}?action=updprofile&user_id=' +
            user_id +
            "&fname=" +
            fname +
            "&lname=" +
            lname +
            "&email=" +
            email +
            "&mno=" +
            mno +
            "&addr=" +
            addr +
            "&city=" +
            city +
            "&state=" +
            state));
  }
}
