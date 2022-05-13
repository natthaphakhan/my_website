import 'dart:convert';
import 'package:http/http.dart' as http;

Future<CovidData> getCovidData() async {
  final response = await http.get(
      Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all'));
  return CovidData.fromJson(
      jsonDecode(response.body)[0] as Map<String, dynamic>);
}

class CovidData {
  final String txnDate;
  final int newCase;
  final int totalCase;
  final int newCaseExcludeabroad;
  final int totalCaseExcludeabroad;
  final int newDeath;
  final int totalDeath;
  final int newRecovered;
  final int totalRecovered;
  final String updateDate;

  const CovidData(
      {required this.txnDate,
      required this.newCase,
      required this.totalCase,
      required this.newCaseExcludeabroad,
      required this.totalCaseExcludeabroad,
      required this.newDeath,
      required this.totalDeath,
      required this.newRecovered,
      required this.totalRecovered,
      required this.updateDate});

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
        txnDate: json['txn_date'],
        newCase: json['new_case'],
        totalCase: json['total_case'],
        newCaseExcludeabroad: json['new_case_excludeabroad'],
        totalCaseExcludeabroad: json['total_case_excludeabroad'],
        newDeath: json['new_death'],
        totalDeath: json['total_death'],
        newRecovered: json['new_recovered'],
        totalRecovered: json['total_recovered'],
        updateDate: json['update_date']);
  }
}
