import 'package:final_project_3/models/album.dart';
import 'package:final_project_3/models/sticker.dart';
import 'package:final_project_3/models/user.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';

class AlbumPage extends StatelessWidget {
  final User user;
  const AlbumPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Column(children: [
              Image.asset(
                './lib/images/game_name.png',
                width: 200,
              ),
              Header(title: user.album!.name),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                LinearProgressIndicator(
                  value: (user.goldStickers + user.silverStickers) /
                      (user.album!.numOfGoldStickers +
                          user.album!.numOfSilverStickers),
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(width: 10),
                Text(
                    '${user.goldStickers + user.silverStickers} / ${user.album!.numOfGoldStickers + user.album!.numOfSilverStickers}')
              ]),
              _buildAlbum(user.album!, user.goldStickers, user.silverStickers)
            ]))));
  }

  Widget _buildAlbum(
      Album album, int numOfGoldStickers, int numOfSilverStickers) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: album.stickers.length,
        itemBuilder: (context, index) {
          if (album.stickers[index].type == "gold" && numOfGoldStickers > 0) {
            numOfGoldStickers--;
            return _buildSticker(album.stickers[index], false);
          }
          if (album.stickers[index].type == "silver" &&
              numOfSilverStickers > 0) {
            numOfSilverStickers--;
            return _buildSticker(album.stickers[index], false);
          }
          return _buildSticker(album.stickers[index], true);
        },
      ),
    );
  }

  Widget _buildSticker(Sticker sticker, bool lock) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Center(
              child: ColorFiltered(
                colorFilter: lock
                    ? const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      )
                    : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.multiply,
                      ),
                child: Image.network(
                  sticker.imageURL,
                  width: 300,
                ),
              ),
            ),
            if (lock)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green[200]!.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
