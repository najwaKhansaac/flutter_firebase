import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "", 
      appId: "1:1091069720559:android:8449a408f76d53d63da81a", 
      messagingSenderId: "", projectId: "pert10-56739")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _mahasiswa = FirebaseFirestore.instance.collection("mahasiswa");
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Mahasiswa"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 500,
              child: StreamBuilder(
                stream: _mahasiswa.snapshots(),
                builder: (context, AsyncSnapshot snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }
                  if (snapshots.hasData) {
                    return ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot records =
                              snapshots.data!.docs[index];
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                    onPressed: (context) {},
                                    icon: Icons.person,
                                    backgroundColor: Colors.amber),
                              ],
                            ),
                            child: ListTile(
                              title: Text(records["Nama"]),
                              subtitle: Text(records["NIM"]),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                },
              ),
            )
          ],
        )),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}