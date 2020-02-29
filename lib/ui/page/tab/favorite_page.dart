import 'package:flutter/material.dart';
import 'package:flutter_music_app/model/favorite_model.dart';
import 'package:flutter_music_app/model/song_model.dart';
import 'package:flutter_music_app/ui/page/player_page.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget _buildSongItem(Song data, bool isCollect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
                width: 50, height: 50, child: Image.network(data.pic)),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: data.url == null
                        ? TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE0E0E0),
                          )
                        : TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.author,
                    style: data.url == null
                        ? TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFFE0E0E0),
                          )
                        : TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
          data.url == null
              ? Icon(
                  Icons.favorite_border,
                  color: Color(0xFFE0E0E0),
                  size: 20.0,
                )
              : isCollect == true
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20.0,
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: 20.0,
                    )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FavoriteModel favoriteModel = Provider.of(context);
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ListView.builder(
              itemCount: favoriteModel.favoriteSong.length,
              itemBuilder: (BuildContext context, int index) {
                Song data = favoriteModel.favoriteSong[index];
                return GestureDetector(
                  onTap: () {
                    if (null != data.url) {
                      SongModel songModel = Provider.of(context);
                      songModel.setSongs(
                          new List<Song>.from(favoriteModel.favoriteSong));
                      songModel.setCurrentIndex(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayPage(
                            nowPlay: true,
                          ),
                        ),
                      );
                    }
                  },
                  child: _buildSongItem(data, favoriteModel.isCollect(data)),
                );
              },
            )));
  }
}