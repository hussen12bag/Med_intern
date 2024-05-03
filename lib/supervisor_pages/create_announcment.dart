import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_intern/Admin_pages/create_Account.dart';
import 'package:med_intern/auth_pages/login.dart';
import 'package:med_intern/components/main_appbar.dart';
import 'package:med_intern/components/main_drawer.dart';
import 'package:med_intern/components/roundbutton.dart';
import 'package:med_intern/components/textform.dart';
import 'package:med_intern/main.dart';
import 'package:med_intern/theme/colors.dart';
import 'package:med_intern/theme/fonts.dart';

class CreateAnnouncment extends StatefulWidget {
  String course_id;
  CreateAnnouncment({ required this.course_id});
  @override
  State<CreateAnnouncment> createState() => _CreateAnnouncmentState();
}

class _CreateAnnouncmentState extends State<CreateAnnouncment> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController();
    final TextEditingController content = TextEditingController();
    final GlobalKey<FormState> fkey = GlobalKey();

    createAnnouncment() async {
      if (fkey.currentState!.validate()) {
        await FirebaseFirestore.instance.collection('announcments').add({
          "title": "${title.text}",
          "content": "${content.text}".replaceAll(" ", ""),
          "superid": "${prefs!.getString('id')}",
          "courseid" : widget.course_id
        }).then((_) {
          Navigator.of(context).pop();
        }).catchError((_) {
          print("an error occured");
        });
      }
    }

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MainAppBar(
          title: 'Childhood diseases',
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: maincolor, spreadRadius: 1, blurRadius: 2)
              ]),
          child: Form(
            key: fkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Announcment',
                  style: sub_green_bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                Textform(
                    val: (p0) {
                      if (p0 != null && p0.isNotEmpty) {
                      } else {
                        return 'rquired';
                      }
                    },
                    controller: title,
                    text: 'title',
                    textInputType: TextInputType.text,
                    obscure: false,
                    color: Colors.white,
                    height: 60,
                    width: double.infinity),
                const SizedBox(
                  height: 10,
                ),
                Textform(
                    val: (p0) {
                      if (p0 != null && p0.isNotEmpty) {
                      } else {
                        return 'rquired';
                      }
                    },
                    controller: content,
                    text: 'content',
                    textInputType: TextInputType.text,
                    obscure: false,
                    color: Colors.white,
                    height: 60,
                    width: double.infinity),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundButton(
                        fun: () {
                          Navigator.of(context).pop();
                        },
                        label: Text(
                          'Cancle',
                          style: small_black_title,
                        ),
                        width: 100,
                        height: 40,
                        color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    RoundButton(
                        fun: createAnnouncment,
                        label: Text(
                          'Submit',
                          style: small_white_title,
                        ),
                        width: 100,
                        height: 40,
                        color: maincolor),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
