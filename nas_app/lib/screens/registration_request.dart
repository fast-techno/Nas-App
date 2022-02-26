import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nas_app/compnenets/medium_logo.dart';
import 'package:nas_app/compnenets/primary_container.dart';
import 'package:nas_app/compnenets/who_told_you_container.dart';
import 'package:nas_app/utils/app_colors.dart';

class RegistrationRequest extends StatefulWidget {
  const RegistrationRequest({Key? key}) : super(key: key);

  @override
  State<RegistrationRequest> createState() => _RegistrationRequestState();
}

class _RegistrationRequestState extends State<RegistrationRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Column(
            children: [
              const MediumLogo(),
              const SizedBox(height: 20),
              Expanded(
                child: WhoToldYouContainer(
                    title: "مين دلك علينا",
                    spaceTitle: 115,
                    heightContainer: 0
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
