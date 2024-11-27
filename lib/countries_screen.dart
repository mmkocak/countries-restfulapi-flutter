import 'package:flutter/material.dart';
import 'package:flutter_countries_api/countries_services.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({ Key? key }) : super(key: key);

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late Future<List<dynamic>> futureCountries;
  @override
  void initState(){
    super.initState();
    futureCountries = fetchCountries();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureCountries,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text("Failed to load countries"),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center( child: Text("No countries found") );
          }
          final countries = snapshot.data!;
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(countries[index]['name']? ['common'] ?? "Unkown name"),
                subtitle: Text(countries[index]['region'] ?? 'No Region'),
              );
            },
          );
        },
      ),
    );
  }
}