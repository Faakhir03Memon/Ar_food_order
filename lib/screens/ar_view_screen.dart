import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_updated/ar_flutter_plugin_updated.dart';
import 'package:ar_flutter_plugin_updated/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_updated/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_updated/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../models/dish_model.dart';
import '../core/app_colors.dart';
import '../widgets/glass_container.dart';

class ARViewScreen extends StatefulWidget {
  final DishModel dish;

  const ARViewScreen({super.key, required this.dish});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  bool isSurfaceDetected = false;
  String currentStatus = "Scan your table slowly...";

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          _buildOverlay(context),
          _buildStatusIndicator(),
          _buildBackOverlay(context),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTap;
  }

  Future<void> onPlaneOrPointTap(List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    
    if (singleHitTestResult != null) {
      var newAnchor = ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
      
      if (didAddAnchor!) {
        anchors.add(newAnchor);

        // Add the food model
        var newNode = ARNode(
          type: NodeType.webGLB,
          uri: widget.dish.modelUrl,
          scale: vector.Vector3(0.2, 0.2, 0.2),
          position: vector.Vector3(0, 0, 0),
          rotation: vector.Vector4(1, 0, 0, 0),
        );
        
        bool? didAddNode = await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNode!) {
          nodes.add(newNode);
          setState(() {
            currentStatus = "Dish placed! Use gestures to move/rotate.";
          });
        }
      }
    }
  }

  Widget _buildOverlay(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.dish.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionIcon(Icons.refresh_rounded, "Reset", () {
                  for (var node in nodes) {
                    arObjectManager!.removeNode(node);
                  }
                  nodes.clear();
                  anchors.clear();
                  setState(() {
                    currentStatus = "Scan your table slowly...";
                  });
                }),
                _buildActionIcon(Icons.camera_rounded, "Capture", () {}),
                _buildActionIcon(Icons.close_rounded, "Exit", () => Navigator.pop(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryNeon.withOpacity(0.2),
            child: Icon(icon, color: AppColors.primaryNeon),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Center(
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: BorderRadius.circular(30),
          child: Text(
            currentStatus,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildBackOverlay(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
