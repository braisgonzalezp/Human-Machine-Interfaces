
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      height: 70.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)),
      child: TextFormField(
        cursorColor: const Color(0xffD0D0D0),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 40.0,
          ),
          border: InputBorder
              .none, //Para quitar la barrita de debajo del searchBar
          hintStyle: TextStyle(
            color: Color(0xffD0D0D0),
            fontSize: 18.0,
          ),
          hintText: 'Introduce an ingredient...',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some ingredient';
          }

          context.read<FormModel>().setIngredient(value);
          return null;
        },
      ),
    );
  }
}