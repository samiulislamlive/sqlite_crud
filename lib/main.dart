import 'package:flutter/material.dart';
import 'package:sqflite_nigga_project/sql_helper.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String, dynamic>> favourites = [];

  bool _isLoading = true;

  void _refreshFavourites() async{
    var data = await SQLHelper.getItems();
      setState(() {
        favourites = data;
        _isLoading = false;
      });
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully deleted")));
    _refreshFavourites();
  }

  final TextEditingController weightController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController videotitleController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController videoidController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController catController = TextEditingController();
  final TextEditingController packageController = TextEditingController();
  final TextEditingController sivController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController viewController = TextEditingController();
  final TextEditingController createdatController = TextEditingController();
  final TextEditingController uploadtimeController = TextEditingController();
  final TextEditingController modifiedatController = TextEditingController();
  final TextEditingController vController = TextEditingController();

  Future<void> _addItem() async{
    await SQLHelper.createItem(
        weightController.text,
        idController.text,
        userController.text,
        videotitleController.text,
        thumbnailController.text ,
        videoidController.text ,
        typeController.text ,
        catController.text,
        packageController.text,
        sivController.text,
        statusController.text,
        durationController.text,
        viewController.text,
        createdatController.text,
        uploadtimeController.text,
        modifiedatController.text,
        vController.text
    );
    _refreshFavourites();
    // var s = favourites;
       // Safe
    print("number of items inside ${favourites.length ?? 0}");

  }
  void _showForm(int? id) async{
    if(id != null){
      final existingFavourites =
          favourites.firstWhere((element) => element['id'] == id);
      weightController.text = existingFavourites['weight'];
      idController.text = existingFavourites['_id'];
      userController.text = existingFavourites['user'];
      videotitleController.text = existingFavourites['video_title'];
      thumbnailController.text = existingFavourites['thumbnail'];
      videoidController.text = existingFavourites['video_id'];
      typeController.text = existingFavourites['type'];
      catController.text = existingFavourites['cat'];
      packageController.text = existingFavourites['package'];
      sivController.text = existingFavourites['SIV'];
      statusController.text = existingFavourites['status'];
      durationController.text = existingFavourites['duration'];
      viewController.text = existingFavourites['view'];
      createdatController.text = existingFavourites['createdAt'];
      uploadtimeController.text = existingFavourites['uploadtime'];
      modifiedatController.text = existingFavourites['modifiedAt'];
      vController.text = existingFavourites['__v'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: weightController,
                decoration: InputDecoration(hintText: "Weight"),
              ),
              TextField(
                controller: idController,
                decoration: InputDecoration(hintText: "id"),
              ),
              TextField(
                controller: userController,
                decoration: InputDecoration(hintText: "user"),
              ),
              TextField(
                controller: videotitleController,
                decoration: InputDecoration(hintText: "video title"),
              ),
              TextField(
                controller: thumbnailController,
                decoration: InputDecoration(hintText: "thumbnail"),
              ),
              TextField(
                controller: videoidController,
                decoration: InputDecoration(hintText: "vid"),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(hintText: "type"),
              ),
              TextField(
                controller: catController,
                decoration: InputDecoration(hintText: "cat"),
              ),
              TextField(
                controller: packageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "package",
                ),
              ),
              TextField(
                controller: sivController,
                decoration: InputDecoration(hintText: "siv"),
              ),
              TextField(
                controller: statusController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "status"),
              ),
              TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "duration"),
              ),
              TextField(
                controller: viewController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "view"),
              ),
              TextField(
                controller: createdatController,
                decoration: InputDecoration(hintText: "createdat"),
              ),
              TextField(
                controller: uploadtimeController,
                decoration: InputDecoration(hintText: "upload"),
              ),
              TextField(
                controller: modifiedatController,
                decoration: InputDecoration(hintText: "modify"),
              ),
              TextField(
                controller: vController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "V"),
              ),
              Row(
                children: [
                  ElevatedButton(onPressed: () async{
                    if(id == null){
                      await _addItem();
                    }
                    weightController.text = "";
                    idController.text = "";
                    userController.text = "";
                    videotitleController.text = "";
                    thumbnailController.text = "";
                    videoidController.text = "";
                    typeController.text = "";
                    catController.text = "";
                    packageController.text = "";
                    sivController.text = "";
                    statusController.text = "";
                    durationController.text = "";
                    viewController.text = "";
                    createdatController.text = "";
                    uploadtimeController.text ="";
                    modifiedatController.text = "";
                    vController.text = "";
                    Navigator.pop(context);
                  }, child: Text('Create New')),
                  ElevatedButton(onPressed: () async{
                    Navigator.pop(context);
                  }, child: Text('Cut')),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshFavourites();
    print(".. number of itemd ${favourites.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trying sqflite'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favourites.length,
          itemBuilder: (context, int index) => Container(
            height: 300,
            width: double.infinity,
            color: Colors.orange,
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(favourites[index]['weight']),
                      Text(favourites[index]['_id']),
                      Text(favourites[index]['user']),
                      Text(favourites[index]['video_title']),
                      Text(favourites[index]['thumbnail']),
                      Text(favourites[index]['video_id']),
                      Text(favourites[index]['type']),
                      Text(favourites[index]['cat']),
                      Text(favourites[index]['package'].toString()),
                      Text(favourites[index]['SIV']),
                      Text(favourites[index]['status'].toString()),
                      Text(favourites[index]['duration'].toString()),
                      Text(favourites[index]['view'].toString()),
                      Text(favourites[index]['createdAt']),
                      Text(favourites[index]['uploadtime']),
                      Text(favourites[index]['modifiedAt']),
                      Text(favourites[index]['__v'].toString())
                    ],
                  ),
                ),
                IconButton(onPressed: (){
                  _deleteItem(favourites[index]['id']);
                }, icon: Icon(Icons.delete)),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showForm(null);
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
