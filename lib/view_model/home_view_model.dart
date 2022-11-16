import 'package:flutter/material.dart';
import 'package:sufismart/model/banner_model.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/model/news_model_new.dart';
import 'package:sufismart/model/point_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class HomeViewModel extends ChangeNotifier {
  String? userid = System.data.global.customerNewModel?.userid;
  
  List<BannerModel> _listBanner = BannerModel.dummy();

  Future<List<BannerModel>> listBannerSufi = BannerModel.getAll();

  Future<List<NewsModelNew>> listNewsHomeSufi = NewsModelNew.getNewsHome();

  List<BannerModel> get listBanner => _listBanner;
  set listBanner(List<BannerModel> listBanner) {
    _listBanner = listBanner;
    commit();
  }

  List<NewsModel> _listNews = NewsModel.dummy();
  List<NewsModel> get listNews => _listNews;
  set setListNews(List<NewsModel> listNews) {
    _listNews = listNews;
  }

  Future<PointModel?> getDataPointById({
    required String? id,
  }) {
    return PointModel.getPointUser(id: id);
  }

  Future<void> onRefreshHomePage() async {
    await Future.delayed(const Duration(seconds: 5));   
    if(userid != null){
      getDataPointById;
      commit();
      ModeUtil.debugPrint("check point yes");
      ModeUtil.debugPrint(userid ?? "");
    }
  }


  void commit() {
    notifyListeners();
  }
}
