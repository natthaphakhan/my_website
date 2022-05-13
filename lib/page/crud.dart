import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_website/model/to_do_list_model.dart';

class CRUD extends StatefulWidget {
  const CRUD({Key? key}) : super(key: key);
  final String title = 'CRUD';

  @override
  State<CRUD> createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 485 ? 370 : 500,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Basic "CRUD" System',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                onPressed: () {
                  _showInputCreate();
                },
                child: const Icon(Icons.add),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('toDoList')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Text(
                      streamSnapshot.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  if (streamSnapshot.hasData) {
                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (ctx, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildItem(
                                          streamSnapshot.data!.docs[index]
                                              ['title'],
                                          streamSnapshot.data!.docs[index]
                                              ['body'],
                                          streamSnapshot.data!.docs[index]
                                              ['time']),
                                      Wrap(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                _showInputUpdate(streamSnapshot
                                                    .data!.docs[index].id);
                                              },
                                              icon: const Icon(
                                                Icons.create,
                                                color: Colors.green,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('toDoList')
                                                    .doc(streamSnapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('This page use Cloud Firestore.'),
            ),
            Image.asset('assets/firebase_logo.png', width: 30)
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String _title, String _body, Timestamp _time) {
    DateTime dt = (_time).toDate();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            child: Text(_body),
            width: MediaQuery.of(context).size.width < 485 ? 150 : 350,
          ),
          Text(
            dt.toString(),
            style: const TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 96, 95, 95)),
          )
        ],
      ),
    );
  }

  Future<void> _showInputUpdate(x) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _controller3,
                  maxLength: 50,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                TextFormField(
                  controller: _controller4,
                  maxLength: 500,
                  decoration: InputDecoration(
                      labelText: 'Body',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _controller3.clear();
                  _controller4.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            TextButton(
              child: const Text(
                'Update',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final updateList = ToDoListData(
                    title: _controller3.text,
                    body: _controller4.text,
                    time: Timestamp.now());

                FirebaseFirestore.instance
                    .collection('toDoList')
                    .doc(x)
                    .update(updateList.toJson());

                _controller3.clear();
                _controller4.clear();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInputCreate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _controller1,
                  maxLength: 50,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                TextFormField(
                  controller: _controller2,
                  maxLength: 500,
                  decoration: InputDecoration(
                      labelText: 'Body',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  _controller1.clear();
                  _controller2.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
            TextButton(
              child: const Text(
                'Create',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                create(_controller1.text, _controller2.text);

                _controller1.clear();
                _controller2.clear();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
} // end class
