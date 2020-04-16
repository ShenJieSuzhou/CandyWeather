import 'package:cw_proj/Model/home_entity.dart';
import 'package:cw_proj/common/global.dart';
import 'package:cw_proj/states/CityChangeNotifier.dart';

class SelectedCityModel extends SelCityChangeNotifier{
  List<HomeEntity> get weathers => locationList;

  set weathers(List<HomeEntity> list) {
    Global.homeEntityList.clear();
    Global.homeEntityList = list;
    notifyListeners();
  }

  void addCity(HomeEntity weatherModel){
    weathers.add(weatherModel);
    notifyListeners();
  }

}
