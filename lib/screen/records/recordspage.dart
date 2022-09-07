import 'package:client/helpers/headers.dart';

class RecordsPage extends StatefulWidget {
  static const routeName = recordsPageRoute;
  RecordsPage({Key? key}) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Records"),
        ),
        body: Center(
          child: Text("Records Page"),
        ),
      ),
    );
  }
}