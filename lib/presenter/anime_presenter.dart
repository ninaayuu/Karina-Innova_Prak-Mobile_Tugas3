import 'package:http_request/models/model.dart';
import 'package:http_request/network/base_network.dart';

abstract class AnimeView{
  void showLoading();
  void hideLoading();
  void showAnimeList(List<Anime> animeList);
  void showError(String message);

}

class AnimePresenter {
  final AnimeView view; //nama variabel
  AnimePresenter(this.view);
  
  Future<void> loadAnimeData(String endpoint) async{
    try{
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final animeList = data.map((json) => Anime.fromJson(json)).toList();
      view.showAnimeList(animeList);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    
    }     
  }
}
