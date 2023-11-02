import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/model/details.model.dart';
import 'package:task/utils/api/base_client.dart';
import 'package:task/utils/api/kconstant.api.dart';
import 'package:task/utils/api/response_handle.api.dart';

final detailsProvider = ChangeNotifierProvider<DetailsBloc>((ref) {
  return DetailsBloc();
});

class DetailsBloc extends ChangeNotifier {
  List<DetailModel> detailsList = [];
  final _client = ApiHelper.instance;
  ApiResponse detailsApiResponse = ApiResponse.initial('Empty data');
  void fetchData() async {
    // final apiService = ApiService();
    detailsApiResponse = ApiResponse.loading("");
    notifyListeners();
    try {
      final response = await _client.getRequest(ApiKconstant.detailsUrl);
      response.data.forEach((e) {
        detailsList.add(DetailModel.fromJson(e));
      });
      detailsApiResponse = ApiResponse.completed("");
      notifyListeners();
      log("data $detailsList");
    } catch (e) {
      detailsApiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
