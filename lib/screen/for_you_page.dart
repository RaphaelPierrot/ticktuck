import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/models/post.dart';
import 'package:tiktuck/models/user.dart';
import 'package:tiktuck/widget/postcontent.dart';

class FYpage extends StatefulWidget {
  const FYpage({super.key});

  @override
  State<FYpage> createState() => _FYpageState();
}

class _FYpageState extends State<FYpage> {
  final List<Post> tiktokitems = [
    Post(
        caption: 'caption',
        postedBy: User(
            uid: '',
            email: '',
            username: 'postedBy',
            profileImageUrl: 'img/logo.webp'),
        comment: 3,
        like: 3,
        shared: 3,
        bookmarks: 3,
        video: 'video/video1.mp4',
        audioName: 'audio name'),
    Post(
        caption: 'caption',
        postedBy: User(
            uid: '',
            email: '',
            username: 'postedBy',
            profileImageUrl: 'img/logo.webp'),
        comment: 3,
        like: 3,
        shared: 3,
        bookmarks: 3,
        video: 'video/video2.mp4',
        audioName: ''),
    Post(
        caption: 'caption',
        postedBy: User(
            uid: '',
            email: '',
            username: 'postedBy',
            profileImageUrl: 'img/logo.webp'),
        comment: 3,
        like: 3,
        shared: 3,
        bookmarks: 3,
        video: 'video/video3.mp4',
        audioName: ''),
  ];
  bool _isFollowingSelected = true;
  int snappedPageIndex = 0;
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
            const SizedBox(
              width: 10,
            ),
            Text('|',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: tipoUnselected,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
            const SizedBox(
              width: 10,
            ),
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
                ))
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
