import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChooserPageUserName extends StatelessWidget {
  const ChooserPageUserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: Text(
              "Welcome ${FirebaseAuth.instance.currentUser!.displayName ?? ""}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        const Spacer(
          flex: 20,
        ),
      ],
    );
  }
}

class ChooserPageUserPic extends StatelessWidget {
  const ChooserPageUserPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(image: AssetImage(emptyImage), fit: BoxFit.fill)),
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color.fromARGB(255, 21, 113, 188)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ));
  }
}
