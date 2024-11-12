import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/data/global.dart';
import 'package:tiktuck/widget/progress_bar.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key,required this.viedoUrl,required this.currentIndex,required this.snappedPageIndex});
  final String viedoUrl;
  final int snappedPageIndex;
  final int currentIndex;
  @override
  // ignore: no_logic_in_create_state
  State<VideoWidget> createState() => _VideoWidgetState(viedoUrl,currentIndex,snappedPageIndex);
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  final String viedoUrl;
  final int snappedPageIndex;
  final int currentIndex;
  double _position=0;
  bool isPlaying=true;
  late Future _initializeVideoPlayer;
  _VideoWidgetState(this.viedoUrl,this.currentIndex,this.snappedPageIndex);
  void _options(){setState(() {
    
  });}
  void _autoScroll(){setState(() {
    autoPlay==true? autoPlay=false:autoPlay=true;
  });}
  void _tooglePlayPause(){setState(() {
    _controller.value.isPlaying?_controller.pause():_controller.play();
    setState(() {
      isPlaying=!isPlaying;
    });
  });}
  @override
  void initState() {
    super.initState();
    _controller=VideoPlayerController.asset(viedoUrl);
    _initializeVideoPlayer=_controller.initialize();
    _controller.setLooping(true);
    _controller.addListener(() {if(_controller.value.position.inMilliseconds>0){setState(() {
      _position=double.parse((_controller.value.position.inMilliseconds/_controller.value.duration.inMilliseconds).toStringAsFixed(2));
    });}});
    videoDuration=_controller.value.duration;
    }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    (widget.snappedPageIndex==widget.currentIndex && isPlaying)? _controller.play():_controller.pause();
    return FutureBuilder(future: 
    _initializeVideoPlayer, builder: (context,snapshot){if(snapshot.connectionState==ConnectionState.done){
      return Stack(alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () => {_tooglePlayPause()},
          child: Stack(alignment: Alignment.center,
            children:[VideoPlayer(_controller),IconButton(onPressed: ()=>_tooglePlayPause(), icon: Icon(Icons.play_arrow,color: playColor,size: isPlaying?0:60,))]),),
        ProgressBar(progress: _position,onTap: (double position){
          _controller.seekTo(Duration(milliseconds: (_controller.value.duration.inMilliseconds*position).toInt()));
          setState(() {
            _position=position;
          });
          },)],);}
      else {return Container();}}) ;
  }
}