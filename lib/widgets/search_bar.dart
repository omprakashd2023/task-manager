import 'package:flutter/material.dart';

//Colors
import '../models/colors.dart';

class SearchBar extends StatelessWidget {
  final Function search;
  const SearchBar({
    super.key, 
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onChanged: (value) => search(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: black,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: grey,
          ),
        ),
      ),
    );
  }
}
