import 'package:flutter/material.dart';
import 'package:resumedata/Models/Model_SQL.dart';
import 'package:resumedata/Resume_Detailspages/Resume_Details.dart';

class Resume_List extends StatefulWidget {
  @override
  State<Resume_List> createState() => _Resume_ListState();
}

class _Resume_ListState extends State<Resume_List> {
  List<Map<String, dynamic>> ResumeList = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    var data = await DataSQL.getitems();
    setState(() {
      ResumeList = data;
    });
  }

  void deleitem(int id) async {
    await DataSQL.deletItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item delete successfully")));
    _refreshData();
  }

  void _reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = ResumeList.removeAt(oldIndex);
      ResumeList.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: const Text(
            "Resumes",
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          Flexible(
            child: ResumeList == null
                ? const Center(
                    child: Text("No Data Found !!"),
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReorderableListView.builder(
                      itemCount: ResumeList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          key: ValueKey(index),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Table(

                                      border: TableBorder.all(color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          Text('  Name : ${ResumeList[index]['name']}' ??
                                              'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text('  Dob: ${ResumeList[index]['dob']}' ??
                                              'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text('  Email: ${ResumeList[index]['email']}' ??
                                              'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                              '  Mobile: ${ResumeList[index]['mobileNumber']}' ??
                                                  'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text('  Skills: ${ResumeList[index]['skills']}' ??
                                              'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                              '  Project Detalis: ${ResumeList[index]['projectdetalis']}' ??
                                                  'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text('  Hobbies: ${ResumeList[index]['hob']}' ??
                                              'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                              '  Linked In: ${ResumeList[index]['linked']}' ??
                                                  'no data'),
                                        ]),
                                        TableRow(children: [
                                          Text(
                                              '  Education Details: ${ResumeList[index]['educationdetalis']}' ??
                                                  'no data'),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.orange,
                                    thickness: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            var result1 = Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Resume_Details(),
                                                  settings: RouteSettings(
                                                      arguments:
                                                      ResumeList[index])),
                                            );

                                            if (result1 != null &&
                                                result1 == true) {
                                              _refreshData();
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleitem(ResumeList[index]['id']);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        _reorderData(oldIndex, newIndex);
                      },
                    ),
                ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                onTap: () async {
                  setState(() async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resume_Details(),
                        ));
                    if (result != null && result == "done") {
                      _refreshData();
                    }
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                      child: Text(
                    "Add New",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
