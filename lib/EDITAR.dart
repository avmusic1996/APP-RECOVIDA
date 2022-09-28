
void main() {
  runApp(const Leveluno());
}

class Leveluno extends StatelessWidget {
  const Leveluno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Book List',
      theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      home: const LevelUno(nombre: 'Flutter Book List'),
    );
  }
}

class LevelUno extends StatefulWidget {
  const LevelUno({Key? key, required this.nombre}) : super(key: key);

  final String nombre;

  @override
  State<LevelUno> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LevelUno> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  // TextEditingController authorController = TextEditingController();
  // TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    refreshBooks();
    super.initState();
  }

  // Collect Data from DB
  List<Map<String, dynamic>> books = [];
  void refreshBooks() async {
    final data = await SQLHelper.getBooks();
    setState(() {
      books = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(books);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => Card(
                color: Colors.brown,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  isThreeLine: true,
                  title: Text(books[index]['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // height: 5,
                          fontSize: 20,
                          color: Color(0xFFFFFFFF))),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("by. " + books[index]['author'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFFFFFFFF))),
                      Text(books[index]['year'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 2,
                              color: Color(0xFFFFFFFF))),
                      Text(
                        books[index]['desc'],
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => modalForm(books[index]['id']),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () => deleteBook(books[index]['id']),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalForm(null!);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //Function -> Add
  Future<void> addBook() async {
    await SQLHelper.addBook(nombreController.text, edadController.text);
    refreshBooks();
  }

  // Function -> Update
  Future<void> updateBooks(int id) async {
    await SQLHelper.updateBooks(id, nombreController.text, edadController.text);
    refreshBooks();
  }

  // Function -> Delete
  void deleteBook(int id) async {
    await SQLHelper.deleteBook(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Successfull Delete Book")));
    refreshBooks();
  }

  //Form Add
  void modalForm(int id) async {
    if (id != null) {
      final dataBooks = books.firstWhere((element) => element['id'] == id);
      nombreController.text = dataBooks['nombre'];
      edadController.text = dataBooks['edad'];
      // yearController.text = dataBooks['year'];
      // descController.text = dataBooks['desc'];
    }

    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(hintText: 'nombre'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: edadController,
                      decoration: const InputDecoration(hintText: 'edad'),
                    ),
                    // TextField(
                    //   controller: yearController,
                    //   decoration: const InputDecoration(hintText: 'Year'),
                    // ),
                    // TextField(
                    //   controller: descController,
                    //   decoration: const InputDecoration(hintText: 'Desc'),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (id == null) {
                            await addBook();
                          } else {
                            await updateBooks(id);
                          }

                          // await addBook();
                          nombreController.text = '';
                          edadController.text = '';
                          // yearController.text = '';
                          // descController.text = '';
                          Navigator.pop(context);
                        },
                        child: Text(id == null ? 'Add' : 'Update'))
                  ],
                ),
              ),
            ));
  }
}