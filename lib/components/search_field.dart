import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            IconButton(onPressed: _controller.clear, icon: Icon(Icons.clear)),
        hintText: 'Search template',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
