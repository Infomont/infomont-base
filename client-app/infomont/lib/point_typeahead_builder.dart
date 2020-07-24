import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'db/db_provider.dart';
import 'entities/point.dart';

TypeAheadFormField<Point> buildPointTypeAheadField(String label,
    TextEditingController typeAheadController, onSelect(int id, String name)) {
  return TypeAheadFormField<Point>(
      textFieldConfiguration: TextFieldConfiguration(
          controller: typeAheadController,
          style: TextStyle(color: Color(0xFF5D576B)),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey),
          )),
      suggestionsCallback: (pattern) {
        return DBProvider.db.searchPointByName(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.name),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        typeAheadController.text = suggestion.name;
        onSelect(suggestion.id, suggestion.name);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      });
}
