import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/env.dart';
import 'package:tiktuck/models/post.dart';
import 'package:tiktuck/widget/postcontent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class FYpage extends StatefulWidget {
  const FYpage({super.key});

  @override
  State<FYpage> createState() => _FYpageState();
}

class _FYpageState extends State<FYpage> {
  late IO.Socket socket;
  List<Post> tiktokitems = [];
  bool _isFollowingSelected = true;
  int snappedPageIndex = 0;
  final Dio dio = Dio(BaseOptions(baseUrl: Env.baseUrl));
  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  void _connectToSocket() {
    socket = IO.io('${Env.baseUrl}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connecté au serveur Socket.IO');
    });

    socket.on('videoAdded', (data) {
      setState(() {
        tiktokitems.insert(0, Post.fromJson(data));
      });
    });

    socket.on('disconnect', (_) => print('Déconnecté du serveur'));
  }

  Future<void> _fetchVideos() async {
    try {
      final response = await http.get(Uri.parse('${Env.baseUrl}/api/videos'));

      if (response.statusCode == 200) {
        final List<dynamic> videoData = json.decode(response.body);
        setState(() {
          tiktokitems = videoData.map((data) => Post.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => setState(() {
                      _isFollowingSelected = true;
                    }),
                child: Text(
                  'Following',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: _isFollowingSelected ? tipo : tipoUnselected,
                      fontWeight: FontWeight.w600,
                      fontSize: _isFollowingSelected ? 18 : 14),
                )),
            const SizedBox(width: 10),
            Text('|',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: tipoUnselected,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () => setState(() {
                      _isFollowingSelected = false;
                    }),
                child: Text(
                  'For you',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: _isFollowingSelected ? tipoUnselected : tipo,
                      fontWeight: FontWeight.w600,
                      fontSize: _isFollowingSelected ? 14 : 18),
                )),
          ],
        ),
      ),
      body: PageView.builder(
        onPageChanged: (int page) {
          setState(() {
            snappedPageIndex = page;
          });
        },
        scrollDirection: Axis.vertical,
        itemCount: tiktokitems.length,
        itemBuilder: (context, index) {
          return PostContent(
            item: tiktokitems[index],
            currentIndex: index,
            snappedPageIndex: snappedPageIndex,
          );
        },
      ),
    );
  }
}
