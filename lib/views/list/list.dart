import 'package:flutter/material.dart';
import 'package:http_request/models/model.dart';
import 'package:http_request/presenter/anime_presenter.dart';
import 'package:http_request/views/detail/anime_detail.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen>
    implements AnimeView {
  late AnimePresenter _presenter;
  bool _isLoading = false;
  List<Anime> _animeList = [];
  String? _errorMessage;
  String _currentEndpoint = 'api/amiibo/';

  @override
  void initState() {
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimeData(_currentEndpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadAnimeData(endpoint);
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAnimeList(List<Anime> animeList) {
    setState(() {
      _animeList = animeList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        title: Text(
          "NITENDO AMIIBO LIST",
          style: TextStyle(color: Colors.pink[600]), // Judul AppBar warna pink
        ),
        
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.pink[600]), // Ikon AppBar warna pink
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _fetchData('character'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100], // Warna tombol pink muda
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Character",
                    style: TextStyle(color: Colors.pink[900]), // Teks warna pink tua
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _fetchData('head'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100], // Warna tombol pink muda
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Head",
                    style: TextStyle(color: Colors.pink[900]), // Teks warna pink tua
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink[600],
                    ),
                  )
                : _errorMessage != null
                    ? Center(
                        child: Text(
                          "Error: $_errorMessage",
                          style: TextStyle(color: Colors.pink[600]), // Warna teks error pink
                        ),
                      )
                    : ListView.builder(
                        itemCount: _animeList.length,
                        itemBuilder: (context, index) {
                          final anime = _animeList[index];
                          return Card(
                            color: Colors.pink[50], // Warna latar belakang card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: anime.imageUrl.isNotEmpty
                                    ? Image.network(
                                        anime.imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://placehold.co/600x400',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              title: Text(
                                anime.character,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink[800], // Warna judul pink
                                ),
                              ),
                              subtitle: Text(
                                'Game Sseries ${anime.gameSeries}',
                                style: TextStyle(color: Colors.pink[400]), // Warna subtitle pink lembut
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      head: anime.head,
                                      endpoint: _currentEndpoint,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
