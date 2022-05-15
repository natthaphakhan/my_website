import 'package:flutter/material.dart';
import '../model/covid_model.dart';

class Covid extends StatelessWidget {
  const Covid({Key? key}) : super(key: key);
  final String title = 'Check Covid-19';
  @override
  Widget build(BuildContext context) {
    Future<CovidData> futureCovidData;
    futureCovidData = getCovidData();

    return FutureBuilder<CovidData>(
        future: futureCovidData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                  child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Daily information of COVID-19 in Thailand',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      CardShowCovidData(
                          img: 'assets/covid_icon/patient.png',
                          title: 'New Case:',
                          subtitle: '${snapshot.data!.newCase}'),
                      CardShowCovidData(
                          img: 'assets/covid_icon/gravestone.png',
                          title: 'New Death:',
                          subtitle: '${snapshot.data!.newDeath}'),
                      CardShowCovidData(
                          img: 'assets/covid_icon/vaccine.png',
                          title: 'New Recovered:',
                          subtitle: '${snapshot.data!.newRecovered}'),
                      // Text('txnDate = ${snapshot.data!.txnDate}'),
                      // Text('newCase = ${snapshot.data!.newCase}'),
                      // Text('totalCase = ${snapshot.data!.totalCase}'),
                      // Text(
                      //     'newCaseExcludeabroad = ${snapshot.data!.newCaseExcludeabroad}'),
                      // Text(
                      //     'totalCaseExcludeabroad = ${snapshot.data!.totalCaseExcludeabroad}'),
                      // Text('newDeath = ${snapshot.data!.newDeath}'),
                      // Text('totalDeath = ${snapshot.data!.totalDeath}'),
                      // Text('newRecovered = ${snapshot.data!.newRecovered}'),
                      // Text('totalRecovered = ${snapshot.data!.totalRecovered}'),
                      // Text('updateDate = ${snapshot.data!.updateDate}'),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Update Date: ${snapshot.data!.updateDate}')),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'This page use REST API from\nhttps://covid19.ddc.moph.go.th/',
                    textAlign: TextAlign.center,
                  ),
                ),
              ])),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class CardShowCovidData extends StatelessWidget {
  const CardShowCovidData(
      {Key? key,
      required this.img,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final String img;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 260,
        child: Card(
          child: Column(children: [
            Image.asset(img, scale: 3),
            ListTile(title: Text(title), subtitle: Text(subtitle))
          ]),
        ));
  }
}
