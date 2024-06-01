import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yuktidea_task_app/screens/select_your_country.dart';
import 'package:yuktidea_task_app/screens/terms_conditions.dart';
import 'package:yuktidea_task_app/utils/helper.dart';
import 'package:yuktidea_task_app/widgets/student_agent_card.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/pic2.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.7,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.maxFinite,
              child: Column(
                children: [
                  const Text(
                    "Welcome to Study Lancer",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Please select your role to get registered",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StudentAgentCard(
                        image: 'assets/pic1.jpg',
                        text: "Student",
                        ontap: () {
                          Helper.nextScreen(context, const SelectYourCountry());
                        },
                      ),
                      StudentAgentCard(
                        image: 'assets/pic3.png',
                        text: "Agent",
                        ontap: () {
                          Helper.nextScreen(context, const SelectYourCountry());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "By continuing you agree to our\t\t",
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Helper.nextScreen(
                                  context, const TermsConditions());
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
