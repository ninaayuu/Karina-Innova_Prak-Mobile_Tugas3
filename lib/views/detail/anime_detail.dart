import 'package:flutter/material.dart';
import 'package:http_request/presenter/anime_detail_presenter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.endpoint});
  final int id;
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
    _presenter.loadDetailData(widget.endpoint, widget.id);
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
                            "Name: ${_detailData!['name']}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Family: ${_detailData!['family']}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Kekkei Genkai: ${_detailData!['personal']['kekkeiGenkai'] ?? 'Empty'}",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Jutsu: ${_detailData!['jutsu']}",
                            style: TextStyle(fontSize: 16),
                          ),
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
