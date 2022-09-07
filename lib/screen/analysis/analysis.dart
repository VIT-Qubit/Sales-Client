import 'package:client/helpers/headers.dart';

class AnalysisPage extends StatefulWidget {
  static const routeName = analysisPageRoute;
  AnalysisPage({Key? key}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Analysis"),
        ),
        body: Center(
          child: Text("Analysis Page"),
        ),
      ),
    );
  }
}