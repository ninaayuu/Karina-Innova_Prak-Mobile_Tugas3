import 'package:flutter/material.dart';
import 'package:http_request/presenter/anime_detail_presenter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.head, required this.endpoint});
  final int head;
  final String endpoint;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> implements AnimeDetailView {
  late AnimeDetailPresenter _presenter;
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = AnimeDetailPresenter(this);
    _presenter.loadDetailData(widget.endpoint, widget.head);
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
  void showDetailData(Map<String, dynamic> detailData) {
    setState(() {
      _detailData = detailData;
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
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: const Text("Detail", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 243, 130, 168), // Pink color for the app bar
        elevation: 4,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    "Error: $_errorMessage",
                    style: TextStyle(color: Colors.pink, fontSize: 18),
                  ),
                )
              : _detailData != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _detailData!['images'][0] ??
                                    'https://placehold.co/600x400',
                                height: 250,
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Character: ${_detailData!['character']}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Game Series: ${_detailData!['amiiboSeries']}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        "Tidak ada data!",
                        style: TextStyle(
                            color: Colors.pink, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
    );
  }
}
