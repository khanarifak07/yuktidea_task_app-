import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnterPhoneNumber extends StatelessWidget {
  final Map<String, dynamic> countryData;
  const EnterPhoneNumber({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Enter Phone Number",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Please enter your 10 digit mobile number to receive OTP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.network(
                        countryData['flagURL'],
                        height: 35,
                        width: 35,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        countryData['countryCode'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 20),
                      const SizedBox(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter number",
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
