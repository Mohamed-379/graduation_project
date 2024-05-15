import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  Uri emailUrl = Uri(
    scheme: 'mailto',
    path: "mohamedhieba877@gmail.com",
    queryParameters: {'subject': "Job Offer", 'body': "Hey Mohamed ?....."},
  );
  final Uri linkedInUrl = Uri.parse('https://www.linkedin.com/in/mohamed-a-heiba-260210301/?trk=opento_sprofile_pfeditor');
  final Uri whatsAppUrl = Uri.parse('whatsapp://send?phone=+201559885637&text="Hi Mohamed,\n How are you?"');
  final Uri newsApiUrl = Uri.parse("https://newsapi.org/");
  final String phoneNumber = "+201559885637";
  final String bullet = "\u2022";
  AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    String email = emailUrl.toString().replaceAll('+', '%20');
    emailUrl = Uri.parse(email);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ListTile(
            title: Text(
              "About App",
              style: TextStyle(
                  fontFamily: "Exo", fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle:
              Text("MediaWorld is a news application that includes most of the international news networks.",
                style: TextStyle(color: Colors.black ,fontSize: 17, fontFamily: "Exo"),),
          ),
          ListTile(
            title: Text("Tools",
                style: TextStyle(
                    fontFamily: "Exo", fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: RichText(
              text: TextSpan(text: "This application was developed using:\n\n",
                  style: const TextStyle(fontSize: 17, fontFamily: "Exo", color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "- Ui & Logic:\n",
                    ),
                    TextSpan(
                      text: "$bullet Flutter\n",
                      style: TextStyle(color: Colors.blue)
                    ),
                    TextSpan(
                        text: "$bullet Dart\n",
                        style: TextStyle(color: Colors.blue)
                    ),
                    TextSpan(
                        text: "- DataBase:\n",
                    ),
                    TextSpan(
                        text: "$bullet Json API\n",
                        style: TextStyle(color: Colors.blue)
                    ),
                    TextSpan(
                        text: "$bullet Firebase Services: Authentication,\n  Firestore Database\n",
                        style: TextStyle(color: Colors.blue)
                    ),
                  ]
              ),
      
            ),
          ),
          ListTile(
            title: Text("Note",
                style: TextStyle(
                    fontFamily: "Exo", fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: Text("The API used from news.org and the articles have a 24-hour delay because the API used with this app is free and "
                "to make the articles available in real-time there is a paid subscription.",
              style: TextStyle(fontSize: 17, fontFamily: "Exo", color: Colors.black),
            )
          ),
          ListTile(
            onTap: () async {
              _launchUrl(newsApiUrl);
            },
            leading: Image(image: const AssetImage("assets/images/website.png"),
              height: MediaQuery.of(context).size.height * 0.045,),
            title: const Text("News.org API", style: TextStyle(fontFamily: "Exo", fontSize: 18)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ListTile(
            title: const Text(
              "Contact",
              style: TextStyle(
                  fontFamily: "Exo", fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: [
                ListTile(
                  onTap: () async {
                    _launchUrl(linkedInUrl);
                  },
                  leading: Image(image: const AssetImage("assets/images/linkedin.png"),
                  height: MediaQuery.of(context).size.height * 0.045,),
                  title: const Text("LinkedIn", style: TextStyle(fontFamily: "Exo", fontSize: 18)),
                ),
                ListTile(
                  onTap: () async {
                    _launchUrl(emailUrl);
                  },
                  leading: Image(image: const AssetImage("assets/images/email.png"),
                    height: MediaQuery.of(context).size.height * 0.045,),
                  title: const Text("Email", style: TextStyle(fontFamily: "Exo", fontSize: 18)),
                ),
                ListTile(
                  onTap: () async {
                    _launchUrl(whatsAppUrl);
                  },
                  leading: Image(image: const AssetImage("assets/images/whatsapp.png"),
                    height: MediaQuery.of(context).size.height * 0.045,),
                  title: const Text("WhatsApp", style: TextStyle(fontFamily: "Exo", fontSize: 18)),
                ),
                ListTile(
                  onTap: () {
                    _makePhoneCall(phoneNumber);
                  },
                  leading: Image(image: const AssetImage("assets/images/phone-call.png"),
                    height: MediaQuery.of(context).size.height * 0.045,),
                  title: const Text("Phone Call", style: TextStyle(fontFamily: "Exo", fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}