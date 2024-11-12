import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/widget/animated_logo.dart';
import 'package:tiktuck/widget/avatar.dart';
import 'package:tiktuck/widget/social_button.dart';
import 'package:tiktuck/widget/video_widget.dart';
import 'package:marquee/marquee.dart'; import '../models/post.dart';

class PostContent extends StatefulWidget {
  final Post item;
  final int currentIndex;
  final int snappedPageIndex;
  const PostContent({super.key,required this.item, required this.currentIndex, required this.snappedPageIndex});

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoWidget(viedoUrl: widget.item.video,snappedPageIndex: widget.currentIndex,currentIndex: widget.snappedPageIndex,),
        Column(
        children: [
          
          Expanded(
            child: Row(
              children:[
                  Expanded(child: 
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10),child: 
                      Column(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start, children: 
                        [Text('@${widget.item.postedBy.username}',style: TextStyle(color: tipo, fontWeight: FontWeight.w600)),
                        Text(widget.item.caption,style: TextStyle(color: tipo, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8,),
                        Row(children: [Icon(CupertinoIcons.music_note_2,size: 15,color: tipo,),
                        const SizedBox(width: 8,),
                        SizedBox(height: 20,width: MediaQuery.of(context).size.width/2,
                          child: Marquee(text: "${widget.item.audioName}   •   ",
                          velocity: 10,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: tipo,fontSize:15),
                          )),
                        
                         ],),
                         const SizedBox(height: 8,),
                        ]),),),
                  Container(
                    width: 80,
                    padding:const EdgeInsets.only(bottom:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Avatar(),
                        SocialButton(icon:  Icon(Icons.favorite,color: socialButtonColor, size: 45), number: widget.item.like),
                        SocialButton(icon:  Icon(Icons.comment,color: socialButtonColor, size: 45), number: widget.item.comment),
                        SocialButton(icon:  Icon(Icons.bookmark,color: socialButtonColor, size: 45), number: widget.item.bookmarks),
                        SocialButton(icon:  Icon(Icons.share,color: socialButtonColor, size: 45), number: widget.item.shared),
                        AnimatedLogo(item: widget.item)
                      ],
                    ),
                  )],),),
          ],
      ),]
    )
    ;
  }
}