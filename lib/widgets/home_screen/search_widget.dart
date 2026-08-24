import 'package:flutter/material.dart';
import 'package:messenger/generated/l10n.dart';
import 'package:messenger/extensions/theme_data_ext.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _controller,
              focusNode: _focusNode,
              onTap: () {
                setState(() {
                  isFocus = true;
                });
              },
              onTapOutside: (_) {
                setState(() {
                  isFocus = false;
                  _focusNode.unfocus();
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: s.hint_search,
                border: InputBorder.none,
              ),
            ),
          ),
          if (isFocus)
            IconButton(
              onPressed: () {
                setState(() {
                  _controller.text = "";
                });
              },
              icon: Icon(Icons.cancel),
            )
          else
            SizedBox(width: 48),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
