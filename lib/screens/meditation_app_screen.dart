import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_meditation_app/models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({Key? key}) : super(key: key);

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
        auidoPath: "assets/audios/forest.mp3",
        imagePath: "assets/images/forest.jpeg",
        name: "Forest"),
    Item(
        auidoPath: "assets/audios/night.mp3",
        imagePath: "assets/images/night.jpeg",
        name: "Night"),
    Item(
        auidoPath: "assets/audios/ocean.mp3",
        imagePath: "assets/images/ocean.jpeg",
        name: "Ocean"),
    Item(
        auidoPath: "assets/audios/waterfall.mp3",
        imagePath: "assets/images/waterfall.jpeg",
        name: "Waterfall"),
    Item(
        auidoPath: "assets/audios/wind.mp3",
        imagePath: "assets/images/wind.jpeg",
        name: "Wind"),
  ];

  final AudioPlayer audioPlayer= AudioPlayer();
  int? playingIndex;

  Widget showIcon(int currentIndex){
    if(playingIndex==currentIndex){
      return FaIcon(FontAwesomeIcons.stop);
    }else{
      return FaIcon(FontAwesomeIcons.play);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].imagePath),
                    ),
                  ),
                  child: ListTile(
                    title: Text(items[index].name),
                    leading:IconButton(
                    icon:showIcon(index) ,
                    onPressed:() async{
                      if(playingIndex==index){
                        setState(() {
                          playingIndex=null;
                        });
                        audioPlayer.stop();

                      }
                      else{
                        await audioPlayer.setAsset(items[index].auidoPath);
                        audioPlayer.play();

                        setState(() {
                          playingIndex=index;
                        });
                      }

                     },
                     ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
