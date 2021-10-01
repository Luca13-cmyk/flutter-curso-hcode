import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo lugar'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Titulo',
                        ),
                      ),
                      SizedBox(height: 10),
                      ImageInput(this._selectImage),
                      SizedBox(height: 10),
                      LocationInput(),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  onPrimary: Colors.black,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            )
            // ElevatedButton(
            //   onPressed: _submitForm,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.add),
            //       Text('Adicionar'),
            //     ],
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     elevation: 0,
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     primary: Theme.of(context).accentColor,
            //     onPrimary: Colors.black,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(0),
            //     ),
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 30,
            //       vertical: 8,
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
