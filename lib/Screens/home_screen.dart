import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_model.dart';
import '../Services/weather_services.dart';
import '../Utils/location_converter.dart';
import '../Widgets/reusable_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // weather services class
  WeatherServices weatherServices = WeatherServices();

  // DateTime dateTime = DateTime.now();
  String dateFormat = DateFormat('EEEE d MMM yyyy').format(DateTime.now());

  // location converter class
  LocationConverter locationConverter = LocationConverter();

  // Search controller
  TextEditingController countryController =
      TextEditingController(text: "Karachi");

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  bool isData = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * .02),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.menu_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
                // search bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    // onEditingComplete: locationConverter.getLatLng(countryController.text),
                    controller: countryController,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search Country",
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (countryController.text.isNotEmpty) {
                            locationConverter
                                .getLatLng(countryController.text.toString());
                            print(countryController.text);
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xff1e1644),
                                  content: Text(
                                    "Please fill out this field",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        // borderSide: const BorderSide(
                        //   color: Colors.red,
                        //   width: 10,
                        // ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                // future builder
                FutureBuilder(
                  // false me data search se update nai ho raha lekn shuru me karachi ka data araha ha...
                  // true me data search se update ho raha ha lekn shuru me karachi ka data nai araha...
                  future: isData
                      ? weatherServices.fetchWeatherData(
                          locationConverter.latitude,
                          locationConverter.longitude)
                      : weatherServices.fetchWeatherData(
                          '24.860735', '67.001137'),
                  builder: ((context, AsyncSnapshot<WeatherModel> snapshot) {
                    if (snapshot.hasData) {
                      isData = true;
                      // setState(() {
                      //   isData = !isData;
                      // });
                      print(locationConverter.latitude);
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // this
                          SizedBox(height: height * 0.03),
                          Text(
                            "${snapshot.data!.name.toString()}, ${snapshot.data!.sys!.country.toString()}",
                            // "${snapshot.data!.location!.name.toString()},${snapshot.data!.location!.country.toString()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Container(
                            height: height / 2,
                            width: height / 2.5,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff1e1644), Color(0xff2e226a)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListView.builder(
                              itemCount: snapshot.data!.weather!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // icon, title, subtitle, degree, sub container
                                    const Image(
                                      image: NetworkImage(
                                        'https://cdn2.iconfinder.com/data/icons/weather-flat-14/64/weather02-512.png',
                                        scale: 5,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      snapshot.data!.weather![index].main
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      dateFormat,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 170, 170, 170),
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      '${snapshot.data!.main!.temp!.truncate().toString()}\u2103',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ReusableContainerWidget(
                                            //
                                            img:
                                                "https://cdn-icons-png.flaticon.com/512/1146/1146858.png",
                                            tempText: "25%",
                                            simpleText: "Cloudy"),
                                        ReusableContainerWidget(
                                            img:
                                                "https://cdn-icons-png.flaticon.com/512/3445/3445722.png",
                                            tempText: "65%",
                                            simpleText: "Wind"),
                                        ReusableContainerWidget(
                                            img:
                                                "https://cdn-icons-png.flaticon.com/512/3104/3104619.png",
                                            tempText: "10%",
                                            simpleText: "Sunny"),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          // SizedBox(height: height * 0.03),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: const [
                          //     Text(
                          //       "Today",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //       ),
                          //     ),
                          //     Text(
                          //       "Next Week",
                          //       // textAlign: TextAlign.left,
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: height * 0.02),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     // ReusableContainerWidget(
                          //     //     timeText: "Now",
                          //     //     tempText:
                          //     //         " ${snapshot.data!.main!.temp!.truncate().toString()}\u2103"),
                          //     // ReusableContainerWidget(timeText: "12:00 PM"),
                          //     // ReusableContainerWidget(timeText: "03:00 PM"),
                          //     // ReusableContainerWidget(timeText: "06:00 PM"),
                          //   ],
                          // ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.hasError}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
