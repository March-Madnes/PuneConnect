import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nfc_manager/nfc_manager.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Scanner"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                child: Text('Read NFC Chip'), onPressed: _tagRead
              ),
              ValueListenableBuilder<dynamic>(
                valueListenable: result,
                builder: (context, value, _) =>
                    Text('${value ?? ''}'),
              ),
            ],
          ),
          MobileScanner(
            allowDuplicates: true,
            controller: cameraController,
            onDetect: _foundBarcode,
          ),
        ],
      ),
    );
  }
  //nfc reader function
  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {

      result.value = tag.data;
      await NfcManager.instance.stopSession();
      _foundBarcode;

      // showDialog<String>(
      //         context: context,
      //         builder: (context) => AlertDialog(
      //           title: const Text('Alert!'),
      //           content: const Text('The alert description goes here.'),
      //           actions: [
      //             TextButton(
      //               onPressed: () => Navigator.pop(context, 'Cancel'),
      //               child: const Text('Cancel'),
      //             ),
      //             TextButton(
      //               onPressed: () => Navigator.pop(context, 'OK'),
      //               child: const Text('OK'),
      //             ),
      //           ],
      //         ),
      //       );
    });
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          FoundCodeScreen(screenClosed: _screenWasClosed, value: code),));
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Scanned Code:", style: TextStyle(fontSize: 20,),),
              SizedBox(height: 20,),
              Text(widget.value, style: TextStyle(fontSize: 16,),),
            ],
          ),
        ),
      ),
    );
  }
}