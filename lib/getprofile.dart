import 'main.dart';
import 'dart:convert';
import 'updateprofile.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String user_id = storage.read('userdata');
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  void fetchdata() async {
    print(user_id);
    var url =
        "https://vstechno.co.in/news/api/user.php?action=getprofiledetails&user_id=$user_id";

    var response = await get(Uri.parse(url));
    var itam = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      setState(
        () {
          storage.write('userid', itam[0]["Users_id"]);
          storage.write('Fnamne', itam[0]["FirstName"]);
          storage.write('Lname', itam[0]["LastName"]);
          storage.write('id', itam[0]["EmailId"]);
          storage.write('Contact', itam[0]["MobileNo"]);
          storage.write('Address', itam[0]['Address']);
          storage.write('city', itam[0]['City']);
          storage.write('State', itam[0]["State"]);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    )),
                child: ListTile(
                  title: const Text('U_id'),
                  subtitle: Text('${storage.read('userid')}'),
                )),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('F_name'),
                subtitle: Text('${storage.read('Fnamne')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('L_name'),
                subtitle: Text('${storage.read('Lname')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('Mail'),
                subtitle: Text('${storage.read('id')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('Contact'),
                subtitle: Text('${storage.read('Contact')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('Address'),
                subtitle: Text('${storage.read('Address')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('City'),
                subtitle: Text('${storage.read('city')}'),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Colors.black, style: BorderStyle.solid)),
              child: ListTile(
                title: const Text('State'),
                subtitle: Text('${storage.read('State')}'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 180,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  backgroundColor: const Color.fromARGB(255, 102, 100, 193),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => uprofile()),
                  );
                },
                icon: const Icon(Icons.system_security_update_outlined,
                    color: Colors.black),
                label: const Text(
                  'Profile Update',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
