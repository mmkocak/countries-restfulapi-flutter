//Apimizin den gelen verielri gösterdiğimiz sayfa
import 'package:flutter/material.dart';
import 'package:flutter_countries_api/countries_services.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late Future<List<dynamic>> futureCountries;
  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Countries Api Örneği"),
      ),
      body: FutureBuilder(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return  const Center(
              child: Text("Failed to load countries"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return  const Center(child: Text("No countries found"));
          }
          final countries = snapshot.data!;
          return Scrollbar(
            thickness: 10.0,
            radius: const Radius.circular(20),

            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                bool isEvenRow = index % 2 == 0;
                return Container(
                  color: isEvenRow ? Colors.white60: Colors.redAccent,
                  child: ListTile(
                    title: Text(
                      countries[index]['name']?['common'] ?? "Unkown name",
                      style: TextStyle(
                        color: isEvenRow ? Colors.black : Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      countries[index]['region'] ?? 'No Region',
                      style: TextStyle(
                        color: isEvenRow ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
