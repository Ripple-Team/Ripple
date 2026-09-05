// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:flutter/material.dart';
import 'package:ripple/generated/l10n.dart';
import 'package:ripple/extensions/theme_data_ext.dart';

/// Search input field with a clear button shown only when focused.
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryBackground,
          borderRadius: BorderRadius.circular(50),
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
            Visibility(
              maintainState: true,
              visible: isFocus,
              child: IconButton(
                style: ButtonStyle(
                  mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
                ),
                onPressed: () {
                  setState(() {
                    _controller.text = "";
                    isFocus = false;
                    _focusNode.unfocus();
                  });
                },
                icon: Icon(Icons.cancel),
              ),
            ),
          ],
        ),
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
