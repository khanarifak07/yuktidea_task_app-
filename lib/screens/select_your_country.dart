import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea_task_app/config.dart';
import 'package:yuktidea_task_app/screens/enter_your_phone_number.dart';
import 'package:yuktidea_task_app/utils/helper.dart';

class SelectYourCountry extends StatefulWidget {
  const SelectYourCountry({super.key});

  @override
  State<SelectYourCountry> createState() => _SelectYourCountryState();
}

class _SelectYourCountryState extends State<SelectYourCountry> {
  List<Map<String, dynamic>> countryListsData = [];
  List<Map<String, dynamic>> filteredCountryLists = [];
  Future<void> getCountryLists() async {
    try {
      //dio instance
      Dio dio = Dio();
      //make dio get request
      Response response = await dio.get(getCountryListsURL);
      //handle response
      if (response.statusCode == 200) {
        log("${response.data['data']}");
        var countryData = response.data['data'];
        List<Map<String, dynamic>> tempdata = [];
        for (var data in countryData) {
          String flagURL = data['flag'];
          String name = data['name'];
          String countryCode = data['tel_code'];

          tempdata.add({
            'flagURL': flagURL,
            'name': name,
            'countryCode': countryCode,
          });
          //update state with the fetched data
          setState(() {
            countryListsData = tempdata;
            filteredCountryLists = List.from(countryListsData);
          });
        }
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching country lists $e");
    }
  }

  void filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountryLists = List.from(countryListsData);
      } else {
        filteredCountryLists = countryListsData
            .where((country) =>
                country['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    getCountryLists();
    super.initState();
  }

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
      body: countryListsData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Text(
                  "Select Your Country",
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      onChanged: filterCountries,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText: 'Search',
                        border: InputBorder.none,
                        fillColor: const Color(0xff4b4e4f),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCountryLists.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> countryLists =
                          filteredCountryLists[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          onTap: () {
                            Helper.nextScreen(
                                context,
                                EnterPhoneNumber(
                                  countryData: countryLists,
                                ));
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: SvgPicture.network(
                                      countryLists['flagURL'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(countryLists['name']),
                                ],
                              ),
                              Text(countryLists['countryCode']),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
