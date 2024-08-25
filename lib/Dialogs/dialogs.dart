import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void informerDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      );
    },
  );
}

void dialogForLogOut(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              const Spacer(
                flex: 30,
              ),
              const Expanded(
                  flex: 20,
                  child: Text(
                    "Do You really want to logout",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.center,
                  )),
              const Spacer(
                flex: 10,
              ),
              Expanded(
                  flex: 30,
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 15,
                      ),
                      Expanded(
                          flex: 30,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                            child: const Text("No",
                                style: TextStyle(color: Colors.white)),
                          )),
                      const Spacer(
                        flex: 10,
                      ),
                      Expanded(
                          flex: 30,
                          child: MaterialButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                              SchedulerBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(FirstPage.pageName);
                                },
                              );
                            },
                            color: Colors.blue,
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const Spacer(
                        flex: 15,
                      ),
                    ],
                  )),
              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ),
      );
    },
  );
}
