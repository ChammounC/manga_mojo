
import 'package:mangamojo/models/anime.dart';
import 'package:mangamojo/models/card.dart';
import 'package:mangamojo/models/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/api.dart';

class DataService with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';
  List<CardModel> searchList = [];
  List<Recommendation> recommendationList = [];
  late int genreId;
  late Anime animeData = Anime();
  int homePage=1;


  Future<void> getHomeData({String category = 'airing',int page=1}) async {
    homePage=page;
    String url = '$BASE_URL/top/anime?filter=$category&limit=24&page=$page';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List items = response.data['data'];
      searchList = items.map((data) => CardModel.fromJson(data)).toList();
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.unknown) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> searchData(String query) async {
    final String url =
        '$BASE_URL/search/anime?q=$query&page=1&limit=12';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<CardModel> tempData = [];
      List items = response.data['results'];
      tempData = items.map((data) => CardModel.fromJson(data)).toList();
      searchList = tempData;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.unknown) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> getAnimeData(int malId) async {
    final String url = '$BASE_URL/anime/$malId';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      animeData = Anime.fromJson(response.data['data']);
      await getRecommendationData(animeData.malId);
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.unknown) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }

  Future<void> getRecommendationData(int genreId) async {
    final String url = '$BASE_URL/anime/$genreId/recommendations';
    try {
      isLoading = true;
      isError = false;
      var dio = Dio();
      var response = await dio.get(url);
      List<Recommendation> tempRecommendation = [];
      List items = response.data['data'];
      tempRecommendation =
          items.map((data) => Recommendation.fromJson(data)).take(5).toList();
      recommendationList = tempRecommendation;
      isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        isError = true;
        errorMessage = 'An Error Has Occured Please Try Again';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.connectionTimeout) {
        isError = true;
        errorMessage = 'Your Connection has Timed Out';
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Unable to Connect to the Server';
        isError = true;
        notifyListeners();
        return;
      }
      if (e.type == DioErrorType.unknown) {
        errorMessage = 'Something Went Wrong\nPlease Check Your Connection';
        isError = true;
        notifyListeners();
        return;
      }
    } catch (e) {}
  }
}