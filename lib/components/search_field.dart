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
        contentPadding: const EdgeInsets.all(10.0),
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            IconButton(onPressed: _controller.clear, icon: Icon(Icons.clear)),
        hintText: 'Search template',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }
}
