import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';

class ImageStatusDialog extends StatelessWidget {
  final ImageModel image;

  const ImageStatusDialog(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('图片详情'),
      children: _buildListItem(image),
    );
  }

  List<Widget> _buildListItem(ImageModel image) {
    final list = <Widget>[];

    final id = image.id;
    list.add(_ImageStatusListTile('Id', '$id'));

    final width = image.width;
    final height = image.height;
    list.add(_ImageStatusListTile('Size', '$width x $height'));

    final source = image.source;
    if (source != null) {
      list.add(_ImageStatusListTile('Source', source));
    }

    list.add(_ImageStatusListTile('Rating', image.rating ?? ''));

    return list;
  }
}

class _ImageStatusListTile extends StatelessWidget {
  final String name;
  final String value;

  const _ImageStatusListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // 复制预留。
        },
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xffcccccc), style: BorderStyle.solid))),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 80,
                  child: _imageStatusListText(name),
                ),
              ),
              Expanded(
                child: _imageStatusListText(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _imageStatusListText(String value) {
    return Text(
      value,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}