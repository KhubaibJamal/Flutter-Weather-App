import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/Services/weather_service.dart';
import 'package:weather_app/Widgets/reusable_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // weather services class
  WeatherServices weatherServices = WeatherServices();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * .02),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
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
              // future builder
              FutureBuilder(
                future: weatherServices.fetchWeatherData(),
                builder: ((context, AsyncSnapshot<WeatherModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        // this
                        SizedBox(height: height * 0.03),
                        Text(
                          // Country name
                          snapshot.data!.location!.name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
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
                          child: Column(
                            children: [
                              // icon, title, subtitle, degree, subcoantainer
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Next Week",
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            ReusableContainerWidget(),
                            ReusableContainerWidget(),
                            ReusableContainerWidget(),
                            ReusableContainerWidget(),
                          ],
                        ),
                      ],
                    );
                  }
                  // else if (snapshot.hasError) {
                  //   return const Center(
                  //     child: Text(
                  //       "Some Error Occurred",
                  //       style: TextStyle(fontSize: 18.0, color: Colors.white),
                  //     ),
                  //   );
                  // }
                  else {
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
    );
  }
}
