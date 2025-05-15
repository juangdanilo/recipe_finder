import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final void Function(String) onSearch;

  const SearchDialog({
    super.key,
    required this.onSearch,
    this.title = 'Search',
    this.hintText = 'Write here...',
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        autofocus: true,
        onSubmitted: (value) {
          onSearch(value);
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onSearch(controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Search'),
        ),
      ],
    );
  }
}