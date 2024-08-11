import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Terminal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthMonitoringScreen(),
    );
  }
}

class HealthMonitoringScreen extends StatelessWidget {
  const HealthMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const CustomDrawer(currentPage: 'health_monitoring'),
      appBar: AppBar(
        title: const Text("Health Monitoring"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          child: Container(
            width: Width * 0.6,
            height: Height * 0.1,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(16)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-4, 2),
                    blurRadius: 10,
                  )
                ]),
            child: Center(
              child: Text(
                "Connect To Hub",
                style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  bool connected = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetoothConnect]?.isGranted ?? false) {
      fetchDevices();
    } else {
      // Handle permission denial
      print("Permissions not granted.");
    }
  }

  Future<void> fetchDevices() async {
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {});
    } catch (e) {
      print('Error fetching bonded devices: $e');
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        selectedDevice = device;
        connected = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TerminalScreen(device: device, connection: connection),
        ),
      );
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index].name ?? 'Unknown Device'),
            subtitle: Text(devices[index].address.toString()),
            onTap: () => connectToDevice(devices[index]),
          );
        },
      ),
    );
  }
}

class TerminalScreen extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothConnection connection;

  TerminalScreen({required this.device, required this.connection});
Future<void > OpenInWebView(String url)async{
  if(!await  launchUrl(Uri.parse(url),mode: LaunchMode.inAppBrowserView)){
    throw Exception('Could not Launch Hub');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${device.name}'),
        actions: [
          IconButton(onPressed: (){
            OpenInWebView('http://owaisrizwan.dx.am/esp_read.php');
          }, icon: Icon(Icons.monitor_heart_sharp))
        ],
      ),
      body: TerminalWidget(connection: connection),
    );
  }
}

class TerminalWidget extends StatefulWidget {
  final BluetoothConnection connection;

  TerminalWidget({required this.connection});

  @override
  _TerminalWidgetState createState() => _TerminalWidgetState();
}

class _TerminalWidgetState extends State<TerminalWidget> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> messages = [];
  late BluetoothConnection connection;

  @override
  void initState() {
    super.initState();
    connection = widget.connection;
    connection.input!.listen((data) {
      setState(() {
        messages.add(String.fromCharCodes(data));
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage(String message) {
    connection.output.add(Uint8List.fromList(message.codeUnits));
    connection.output.allSent.then((_) {
      setState(() {
        messages.add(message);
        _scrollToBottom();
      });
    });
    _controller.clear();
  }

  @override
  void dispose() {
    connection.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(messages[index]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  sendMessage(_controller.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
