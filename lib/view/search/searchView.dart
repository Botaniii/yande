import 'package:flutter/material.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/tagService.dart';
import 'resultView.dart';

class TagSearchView extends StatefulWidget {
  static const title = 'Tag搜索';
  static const route = '/search';

  const TagSearchView({super.key});

  @override
  State<StatefulWidget> createState() => _TagSearchState();
}

class _TagSearchState extends State<TagSearchView> {
  List<TagModel> tagList = <TagModel>[];
  final TextEditingController _searchQuery = TextEditingController();
  bool isLoading = false;
  String lastSearchWord = '';

  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back, color: Colors.black45),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(onSearch);
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  void onSearch() async {
    if (mounted) {
      setState(() {});
    }
    isLoading = true;
    final result = await searchTag(_searchQuery.text);
    lastSearchWord = _searchQuery.text;

    if (lastSearchWord == _searchQuery.text) {
      isLoading = false;
    }
    tagList = result;
    if (mounted) {
      setState(() {});
    }
  }

  Future<List<TagModel>> searchTag(String name) async {
    return TagService.getTagByNameOrderAESC(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: buildLeading(context),
        title: buildSearchInput(),
        actions: <Widget>[
          _showLoadingStatus(isLoading),
        ],
      ),
      body: ListView(
        children: tagList
            .map((tag) => _buildTagListTile(tag))
            .toList(),
      ),
    );
  }

  TextField buildSearchInput() {
    return TextField(
      decoration: const InputDecoration(
        hintText: '请输入需要搜索的tag',
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        border: InputBorder.none,
      ),
      controller: _searchQuery,
    );
  }

  Widget _buildTagListTile(TagModel tag) {
    final chipNames = <String>[];
    if (tag.type != null && tag.type! >= 0 && tag.type! <= 3) {
      chipNames.add(TagType[tag.type!] ?? '');
    }
    return MySearchListTile(
      name: tag.name ?? '',
      chipNameList: chipNames,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return ResultView(
                    tags: tag.name ?? '',
                  );
                }));
      },
    );
  }

  Widget _showLoadingStatus(bool loadingStatus) {
    if (loadingStatus) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: Center(
          child: SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }
    return Container();
  }
}

class MySearchListTile extends StatelessWidget {
  final String? name;
  final List<String>? chipNameList;
  final GestureTapCallback? onTap;

  const MySearchListTile({
    super.key,
    this.name,
    this.chipNameList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    children.add(Text(name ?? '',
        style: const TextStyle(fontSize: 18), overflow: TextOverflow.fade));
    for (final chipName in chipNameList ?? <String>[]) {
      children.add(_buildChip(chipName));
    }

    return Material(
      child: InkWell(
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20),
          child: Row(
            children: children,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildChip(String name) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 10),
      padding: const EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: const Color(0xffeaeaea)),
      child: SizedBox(
        height: 14,
        child: Text(
          name,
          style: const TextStyle(color: Color(0xff333333), fontSize: 10),
        ),
      ),
    );
  }
}