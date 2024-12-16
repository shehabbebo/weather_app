// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
// import 'package:weather_app/models/weather_model.dart';
// import 'package:weather_app/providers/weather_provider.dart';
// import 'package:weather_app/services/weather_service.dart';

// class SearchPage extends StatelessWidget {
//   String? cityName;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search a City'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: TextField(
//             onChanged: (data) {
//               cityName = data;
//             },
//             onSubmitted: (data) async {
//               cityName = data;

//               BlocProvider.of<WeatherCubit>(context)
//                   .getweather(cityName: cityName!);
//               BlocProvider.of<WeatherCubit>(context).cityName = cityName;
//               Navigator.pop(context);
//             },
//             decoration: InputDecoration(
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//               label: Text('search'),
//               suffixIcon: GestureDetector(
//                   onTap: () async {
//                     WeatherService service = WeatherService();

//                     WeatherModel? weather =
//                         await service.getWeather(cityName: cityName!);

//                     Provider.of<WeatherProvider>(context, listen: false)
//                         .weatherData = weather;
//                     Provider.of<WeatherProvider>(context, listen: false)
//                         .cityName = cityName;

//                     Navigator.pop(context);
//                   },
//                   child: Icon(Icons.search)),
//               border: OutlineInputBorder(),
//               hintText: 'Enter a city',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  // دالة للبحث عن الطقس باستخدام Bloc
  void searchWeather(BuildContext context) async {
    if (cityName == null || cityName!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid city name')),
      );
      return;
    }

    // استدعاء WeatherCubit للحصول على بيانات الطقس
    BlocProvider.of<WeatherCubit>(context).getweather(cityName: cityName!);
    BlocProvider.of<WeatherCubit>(context).cityName = cityName;

    // العودة إلى الصفحة السابقة بعد عملية البحث
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data; // تخزين المدينة في المتغير cityName
            },
            onSubmitted: (data) {
              cityName = data;
              searchWeather(context); // استدعاء دالة البحث عند الإرسال
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: Text('Search'),
              suffixIcon: GestureDetector(
                onTap: () {
                  searchWeather(
                      context); // استدعاء دالة البحث عند الضغط على الأيقونة
                },
                child: Icon(Icons.search),
              ),
              border: OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}
