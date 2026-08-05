import 'package:yande/widget/retryableCachedImage.dart';
import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/shareService.dart';
import 'icons.dart';

class ImageStatusSliverAppBar extends StatefulWidget {
  final ImageModel image;
  final VoidCallback? showDialog;
  final String? heroPrefix;

  const ImageStatusSliverAppBar({
    super.key,
    required this.image,
    this.showDialog,
    this.heroPrefix,
  });

  @override
  State<StatefulWidget> createState() => _ImageStatusSliverAppBarState();
}

class _ImageStatusSliverAppBarState extends State<ImageStatusSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      actions: _buildAppBarActionButton(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Hero(
            tag: '${widget.heroPrefix}${widget.image.id}',
            child: RetryableCachedImage(
              imageUrl: widget.image.sampleUrl ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      pinned: true,
    );
  }

  List<Widget> _buildAppBarActionButton() {
    return <Widget>[
      ImageStatusButton(
        showStatus: widget.showDialog,
      ),
      ImageShareButton(
        onTap: () {
          ShareService.shareImage(widget.image.sampleUrl ?? '');
        },
      ),
    ];
  }
}
class ImageActionButtonFiled extends StatelessWidget {
  final List<Widget> children;

  const ImageActionButtonFiled({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: <Widget>[
          for (var i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: children[i]),
          ],
        ],
      ),
    );
  }
}