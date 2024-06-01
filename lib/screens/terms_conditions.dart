import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:yuktidea_task_app/config.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  //
  String termsAndConditions = '';
  //
  Future<void> getTermsConditios() async {
    try {
      //dio instance
      Dio dio = Dio();
      //make dio get request
      Response response = await dio.get(termsConditionsURL);
      //handle response
      if (response.statusCode == 200) {
        var terms = response.data['data']['content'];
        setState(() {
          termsAndConditions = terms;
        });
      } else {
        log('${response.statusCode}');
      }
    } catch (e) {
      print("Error while getting terms and conditions $e");
    }
  }

  @override
  void initState() {
    getTermsConditios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff212426),
      body: termsAndConditions.isEmpty
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.format_align_left_rounded,
                        color: theme.primary,
                        size: 50,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Terms of Service",
                            style: TextStyle(
                              fontSize: 25,
                              color: theme.primary,
                            ),
                          ),
                          const Text(
                            "Updated 16/03/2024",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Html(
                    data: termsAndConditions,
                    style: {
                      "h1": Style(
                          fontSize: FontSize(20.0),
                          fontWeight: FontWeight.bold,
                          color: theme.primary),
                      "p": Style(
                        fontSize: FontSize(16.0),
                        color: Colors.grey,
                      ),
                      "ul": Style(color: Colors.grey),
                      "li": Style(fontSize: FontSize(16.0), color: Colors.grey),
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
