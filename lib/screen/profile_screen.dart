// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/data/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void addFriend(){setState(() {
    print('add');
  });}
  void settings(){setState(() {
    showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Option 1'),
                        onTap: () {
                          // Traitement pour l'option 1
                          Navigator.pop(context); // Ferme le menu
                        },
                      ),
                      ListTile(
                        title: const Text('Option 2'),
                        onTap: () {
                          // Traitement pour l'option 2
                          Navigator.pop(context); // Ferme le menu
                        },
                      ),
                    ],
                  ),
                );});
  });}
  void changeAccount(String name,String url){setState(() {
    showModalBottomSheet(
              backgroundColor: tipo,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300.0,
                  child: Column(

                    children: <Widget>[
                      const SizedBox(height: 10,),
                      Text('Switch account',style: tipoStyle2,),
                      ListTile(
                        title: Row(
                          children: [
                            CircleAvatar(radius: 20,backgroundImage: NetworkImage(url),),
                            const SizedBox(width: 10,),
                            Text(name,style: tipoStyle3 ,),
                          ],
                        ),
                        onTap: () {
                          
                          Navigator.pop(context); // Ferme le menu
                        },
                      ),
                      
                    ],
                  ),
    );});
  });}int selectedvView = 0;
  void changeViews(int index){
      setState(() {
        selectedvView=index;
      });
    }
  @override
  Widget build(BuildContext context) {
    late String avatarUrl;
    late String username;
    List<Widget> views =[const PostedWidget(),const PrivateWidget(),const RepostedWidget(),const BookmarksWidget(),const LikedWidget()];
    
    
    return StreamBuilder(
      stream: firestore.collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        username=snapshot.data?.data()!['username'] as String;
        avatarUrl=snapshot.data?.data()!['profileImageUrl'] as String;
        return Scaffold(
          extendBody: true,
          backgroundColor: tipo,
          appBar: AppBar(
            leading: IconButton(onPressed: () => addFriend(),icon:  Icon(Icons.person_add_alt_1_rounded,color: backgroundColor,)),
            actions: [IconButton(onPressed:()=> settings(),icon:  Icon(Icons.more_horiz,color: backgroundColor,))],
            backgroundColor: tipo, title: GestureDetector(
              onTap: () => changeAccount(username,avatarUrl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(username,style: tipoStyle2,),
                   Icon(Icons.arrow_drop_down_outlined,color: backgroundColor,),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(color: buttonColor,width: MediaQuery.sizeOf(context).width,height: 30,child: Center(child: Text('Private account',style: TextStyle(color: backgroundColor,fontSize: 15,fontWeight: FontWeight.w200),),),),
                const SizedBox(height: 15,),
                Stack(children: [CircleAvatar(radius: 55,backgroundImage: NetworkImage(avatarUrl),),
                 Positioned(bottom: 0,
                  right: 0,
                  child: CircleAvatar(radius:13,backgroundColor: Colors.blue,child: Center(child: Icon(Icons.add,color: tipo,)),))]),
                const SizedBox(height: 10,),
                Text('@$username',style: tipoStyle3,),
                const SizedBox(height: 10,),
                const Row(mainAxisAlignment: MainAxisAlignment.center,children: [Stats(number: '100', type: 'Following'), SizedBox(width: 30,),Stats(number: '3', type: 'Followers'),SizedBox(width: 30,),Stats(number: '0', type: 'Likes')],),
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [Button(name:Text('Edit profile',style: tipoStyle3,)), const SizedBox(width: 10,),Button(name: Text('Share profile',style: tipoStyle3,),),const SizedBox(width: 10,),Button(name: Icon(Icons.person_add_sharp,color: backgroundColor,),)],),
                const SizedBox(height: 10,),
                Container(decoration: BoxDecoration(color: buttonColor,borderRadius: BorderRadius.circular(5)),child: Text('+ add bio',style: tipoStyle3,)),
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                GestureDetector(onTap: () => changeViews(0),child: ActionBarWidget(icon: Icons.menu_outlined,isSelected: selectedvView==0,)),
                GestureDetector(child: ActionBarWidget(icon: Icons.lock_outline_rounded,isSelected: selectedvView==1,),onTap: ()=> changeViews(1),),
                GestureDetector(onTap: ()=>changeViews(2),child: ActionBarWidget(icon: Icons.rotate_right,isSelected: selectedvView==2,)),
                GestureDetector(onTap: ()=>changeViews(3),child: ActionBarWidget(icon: Icons.bookmark_border_rounded,isSelected: selectedvView==3)),
                GestureDetector(onTap: ()=>changeViews(4),child: ActionBarWidget(icon: Icons.favorite_outline_rounded,isSelected: selectedvView==4,))],),
                Container(height: 2,width: MediaQuery.sizeOf(context).width,color: Colors.grey.shade50,),
                views[selectedvView],
            ],),
          ),
        );
      }
    );
  }
}
class ActionBarWidget extends StatelessWidget {
  const ActionBarWidget({super.key,required this.icon,required, required this.isSelected,});
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon,size: 25,color: isSelected? backgroundColor:unselectedColor,), Container(height: 2,width: 40,color: isSelected? backgroundColor:Colors.transparent,)]
    );
  }
}
class Stats extends StatelessWidget {
  const Stats({super.key, required this.number, required this.type});
  final String number;
  final String type;
  Widget build(BuildContext context) {
    return Column(
      children: [Text(number,style: tipoStyle3,),Text(type,style: GoogleFonts.poppins(color: unselectedColor,fontSize: 15,fontWeight: FontWeight.w300),)],
    );
  }
}
class Button extends StatelessWidget {
   Button({super.key, required this.name});
  Widget name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 35,
        decoration: BoxDecoration(color: buttonColor,borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: name,
      ),
    );
  }
}
class PostedWidget extends StatelessWidget {
  const PostedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child:const Text('Posted'));
  }
}
class PrivateWidget extends StatelessWidget {
  const PrivateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Private'),);
  }
}
class RepostedWidget extends StatelessWidget {
  const RepostedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Reposted'),);
  }
}
class BookmarksWidget extends StatelessWidget {
  const BookmarksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Bookmarks'),);
  }
}
class LikedWidget extends StatelessWidget {
  const LikedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('liked'),);
  }
}