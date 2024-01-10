import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';
import '../providers/post/post_provider.dart';

class SearchField extends StatefulWidget {
  final String? initialValue;
  final String? hint;
  final void Function(String value)? onChanged;

  const SearchField({
    super.key,
    @required this.initialValue,
    @required this.hint,
    @required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with RouteAware {
  final _searchController = BehaviorSubject<String>();
  final _isSearching = BehaviorSubject<bool>();
  TextEditingController? _textEditingController;
  StreamSubscription? _searchSubscription;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.initialValue ?? "");
    _searchSubscription = _searchController
        .distinct()
        .debounceTime(
          const Duration(milliseconds: 500),
        )
        .listen(
      (value) {
        widget.onChanged!(value);
        if (value.isEmpty) {
          _isSearching.add(false);
        } else {
          _isSearching.add(true);
        }
      },
    );
  }

  @override
  void dispose() {
    _textEditingController!.dispose();
    _isSearching.close();
    _searchController.close();
    _searchSubscription!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff929191)),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: _textEditingController,
        onChanged: (String value) {
          if (!(!_searchController.hasValue && value == widget.initialValue)) {
            _searchController.add(value.trimRight().trimLeft());
          }
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide.none,
            ),
            errorBorder: InputBorder.none,
            suffixIcon: StreamBuilder(
                initialData: false,
                stream: _isSearching,
                builder: (context, value) {
                  if (value.data == null) {
                    return Container();
                  }
                  return GestureDetector(
                    onTap: () {
                      _textEditingController!.clear();
                      _searchController.add("");
                      context.read<PostProvider>().refreshPosts();
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(
                      Icons.close,
                      size: theme.iconTheme.size,
                      color: theme.iconTheme.color,
                    ),
                  );
                }),
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: theme.hintColor,
                fontWeight: FontWeight.normal,
                fontSize: 14)),
      ),
    );
  }
}
