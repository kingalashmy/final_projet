import 'package:flutter/material.dart';
import 'package:login_page/sqldb.dart';

class Objectifs extends StatefulWidget {
  final int stageId; // Stage ID
  final bool isProfesseur; // Flag to determine if user is Professeur

  Objectifs({required this.stageId, required this.isProfesseur});

  @override
  _ObjectifsState createState() => _ObjectifsState();
}

class _ObjectifsState extends State<Objectifs> {
  late Future<List<Map<String, dynamic>>> _objectifsFuture;
  late TextEditingController _objectifController;

  @override
  void initState() {
    super.initState();
    _objectifsFuture = _getObjectifs(widget.stageId);
    _objectifController = TextEditingController();
  }

  Future<List<Map<String, dynamic>>> _getObjectifs(int stageId) async {
    List<Map<String, dynamic>> objectifs = await SqlDb().getObjectifs(stageId);
    return objectifs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objectifs for Stage ${widget.stageId}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stage ID is ${widget.stageId}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: widget.isProfesseur,
              child: ElevatedButton(
                onPressed: () {
                  _showObjectifForm(context);
                },
                child: Text('Add Objectif'),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _objectifsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<Map<String, dynamic>>? objectifs = snapshot.data;
                if (objectifs == null || objectifs.isEmpty) {
                  return Text('No Objectifs found.');
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: objectifs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(objectifs[index]['Text_Objectif']),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showObjectifForm(BuildContext context) {
    String objectifText = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Objectif'),
          content: TextField(
            onChanged: (value) {
              objectifText = value;
            },
            controller: _objectifController,
            decoration: InputDecoration(labelText: 'Text Objectif'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save the Objectif text to the database
                await SqlDb().insertObjectif(widget.stageId, objectifText);

                // Close the dialog
                Navigator.of(context).pop();

                // Update the list of Objectifs
                setState(() {
                  _objectifsFuture = _getObjectifs(widget.stageId);
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
