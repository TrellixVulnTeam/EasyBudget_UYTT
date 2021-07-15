
import 'package:easybudget/widgets/easyAppBars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController goalController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      appBar: easyAppBar_back(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 220,
                alignment: Alignment.center,
                child: Text(
                  'New Project',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Project Name *',
                        ),
                        maxLines: 1,
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Please enter a project name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Project Description',
                        ),
                        controller: descController,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        validator: (desc) {
                          if (desc == null || desc.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Project Goal',
                          icon: Icon(Icons.attach_money_sharp),
                        ),
                        controller: goalController,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                        validator: (goal) {
                          if (goal == null || goal.isEmpty) {
                            return 'Please enter a goal';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showFab?Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'btn_close',
              onPressed: () {
                Navigator.of(context).pop([false]);
              },
              child: Icon(Icons.close),
              backgroundColor: Colors.red,
            ),
            FloatingActionButton(
              heroTag: 'btn_save',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop([nameController.text, descController.text, goalController.text]);
                } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: Text('Invalid Project')));
                }
              },
              child: Icon(Icons.done),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ):null,
    );
  }
}