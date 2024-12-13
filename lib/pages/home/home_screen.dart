import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/images.dart';
import '../../controller/HomeController.dart';
import '../../widget/myList.dart';
import '../../widget/my_chart.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.currentWeatherData.main == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                            image: AssetImage('assets/images/cloud-in-blue-sky.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: TextField(
                                onChanged: (value) => controller.city = value,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) => controller.updateWeather(),
                                decoration: InputDecoration(
                                  suffix: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Search'.toUpperCase(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  '${controller.currentWeatherData.name}'.toUpperCase(),
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 50),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    '${controller.currentWeatherData.weather![0].description}',
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 15,
                                                      fontFamily: 'flutterfonts',
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103',
                                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                        color: Colors.black45,
                                                      fontSize: 31,
                                                      fontFamily: 'flutterfonts',
                                                    ),
                                                  ),
                                                  Text(
                                                    'min: ${(controller.currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103',
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'flutterfonts',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:80,
                                                    height:80,
                                                    child: LottieBuilder.asset(Images.cloudyAnim),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'wind ${controller.currentWeatherData.wind!.speed} m/s',
                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                        color: Colors.black45,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'flutterfonts',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                'other city'.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontFamily: 'flutterfonts',
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            MyList(),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'forcast next 5 days'.toUpperCase(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Icon(
                                    Icons.next_plan_outlined,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            MyChart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
