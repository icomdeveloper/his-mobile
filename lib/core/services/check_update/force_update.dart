/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hansy_hr/constants/constatnts.dart';
import 'package:his/core/services/api_services.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ForceYpdate extends StatefulWidget {
  final ApiServices apiServices;

  // Inject the service via constructor

  final String UpdateURL;

  ForceYpdate({Key? key, required this.UpdateURL,required this.apiServices}) : super(key: key);
  @override
  State<ForceYpdate> createState() => _ForceYpdateState();
}

class _ForceYpdateState extends State<ForceYpdate> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckUpdate();
  }
  Map<String, dynamic>? allData;
  Future<void> CheckUpdate() async {

    final url = Uri.parse('${ApiServices.baseUrl}check-update');

    try {
      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer ${widget.Token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("object $data");

        setState(() {
          allData = data['data'];


        });


      } else {
        print('Failed to load profile data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text('Update Available',
          style: TextStyle(color: Colors.white)),
      content: Text(
          'A new version of the app is available. Please update to the latest version.',
          style: TextStyle(color: Colors.white)),
      actions: <Widget>[
        TextButton(
          child: Text('Update', style: TextStyle(color: Colors.white)),
     */
/*     onPressed: () async {
            // Close the dialog
            Navigator.of(context).pop();
            // Check the platform and navigate to the respective app store page
            final String appStoreLink = Platform.isIOS
                ? '${allData?['Ios_Link']}' // Replace with the App Store link
                : '${allData?['Android_Link']}' ; // Replace with the Play Store link
            if (await canLaunch(appStoreLink)) {
              await launch(appStoreLink);
            } else {
             // print("not = $apiAppVersion   $AppCode");
              throw 'Could not launch $appStoreLink';
            }
          },*/ /*

            onPressed: () async {
              Navigator.of(context).pop();

              */
/*String? appStoreLink;

              if (Platform.isIOS) {
                appStoreLink = allData?['Ios_Link'];
              } else {
                appStoreLink = allData?['Android_Link'];
              }

              if (appStoreLink == null || appStoreLink.isEmpty) {
                print("Error: No update link provided.");
                return;
              }*/ /*


              Uri uri = Uri.parse(widget.UpdateURL);

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                print("Could not launch ${widget.UpdateURL}");
              }
            }

        ),
      ],
    );
  }
}
*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:his/core/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceYpdate extends StatelessWidget {
  final ApiServices apiServices;
  final String UpdateURL;

  const ForceYpdate({
    super.key,
    required this.UpdateURL,
    required this.apiServices,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Update Available',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        'A new version of the app is available. Please update to the latest version.',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Update', style: TextStyle(color: Colors.white)),
          onPressed: () async {
            Navigator.of(context).pop(); // Close dialog

            Uri uri = Uri.parse(UpdateURL);

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              print("❌ Could not launch $UpdateURL");
            }
          },
        ),
      ],
    );
  }
}
