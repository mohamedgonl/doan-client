library graphview;

import 'dart:collection';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';

part '../graph/Graph.dart';

part '../graph/Algorithm.dart';

part '../graph/edgerenderer/ArrowEdgeRenderer.dart';

part '../graph/edgerenderer/EdgeRenderer.dart';

part '../graph/forcedirected/FruchtermanReingoldAlgorithm.dart';

part '../graph/layered/SugiyamaAlgorithm.dart';

part '../graph/layered/SugiyamaConfiguration.dart';

part '../graph/layered/SugiyamaEdgeData.dart';

part '../graph/layered/SugiyamaEdgeRenderer.dart';

part '../graph/layered/SugiyamaNodeData.dart';

part '../graph/tree/BuchheimWalkerAlgorithm.dart';

part '../graph/tree/BuchheimWalkerConfiguration.dart';

part '../graph/tree/BuchheimWalkerNodeData.dart';

part '../graph/tree/TreeEdgeRenderer.dart';

typedef NodeWidgetBuilder = Widget Function(Node node);

class GraphView extends StatefulWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;
  final NodeWidgetBuilder builder;
  final bool animated;
  final bool stateEdit;
  final List<ui.Image> listIconEdit;

  const GraphView({
    Key? key,
    required this.graph,
    required this.algorithm,
    this.paint,
    required this.builder,
    this.animated = true,
    this.stateEdit = false,
    required this.listIconEdit,
  }) : super(key: key);

  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    if (widget.algorithm is FruchtermanReingoldAlgorithm) {
      return _GraphViewAnimated(
        key: widget.key,
        graph: widget.graph,
        algorithm: widget.algorithm,
        paint: widget.paint,
        builder: widget.builder,
      );
    } else {
      return _GraphView(
        key: widget.key,
        graph: widget.graph,
        algorithm: widget.algorithm,
        paint: widget.paint,
        builder: widget.builder,
        stateEdit: widget.stateEdit,
        listIconEdit: widget.listIconEdit,
      );
    }
  }
}

class _GraphView extends MultiChildRenderObjectWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;
  final bool stateEdit;
  final List<ui.Image> listIconEdit;

  _GraphView(
      {Key? key,
      required this.graph,
      required this.algorithm,
      this.paint,
      this.stateEdit = false,
      required this.listIconEdit,
      required NodeWidgetBuilder builder})
      : super(key: key, children: _extractChildren(graph, builder)) {
    assert(() {
      if (children.isEmpty) {
        throw FlutterError(
          'Children must not be empty, ensure you are overriding the builder',
        );
      }

      return true;
    }());
  }

  // Traverses the nodes depth-first collects the list of child widgets that are created.
  static List<Widget> _extractChildren(Graph graph, NodeWidgetBuilder builder) {
    final result = <Widget>[];

    graph.nodes.forEach((node) {
      var widget = node.data ?? builder(node);
      result.add(widget);
    });

    return result;
  }

  @override
  RenderCustomLayoutBox createRenderObject(BuildContext context) {
    return RenderCustomLayoutBox(
      graph,
      algorithm,
      paint,
      listIconEdit,
      stateEdit: stateEdit,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomLayoutBox renderObject) {
    renderObject
      ..graph = graph
      ..algorithm = algorithm
      ..edgePaint = paint
      ..stateEdit = stateEdit
      ..listIcon = listIconEdit;
  }
}

class RenderCustomLayoutBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, NodeBoxData>,
        RenderBoxContainerDefaultsMixin<RenderBox, NodeBoxData> {
  late Graph _graph;
  late Algorithm _algorithm;
  late Paint _paint;
  late bool _stateEdit;
  late List<ui.Image> _listIcon;

  RenderCustomLayoutBox(
    Graph graph,
    Algorithm algorithm,
    Paint? paint,
    List<ui.Image> listIconEdit, {
    List<RenderBox>? children,
    bool stateEdit = false,
  }) {
    _algorithm = algorithm;
    _graph = graph;
    edgePaint = paint;
    _listIcon = listIconEdit.map((e) => e).toList();
    _stateEdit = stateEdit;
    addAll(children);
  }

  Paint get edgePaint => _paint;

  set edgePaint(Paint? value) {
    _paint = value ??
        (Paint()
          ..color = Colors.black
          ..strokeWidth = 3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;
    markNeedsPaint();
  }

  Graph get graph => _graph;

  set graph(Graph value) {
    _graph = value;
    markNeedsLayout();
  }

  Algorithm get algorithm => _algorithm;

  set algorithm(Algorithm value) {
    _algorithm = value;
    markNeedsLayout();
  }

  bool get stateEdit => _stateEdit;

  set stateEdit(bool value) {
    _stateEdit = value;
    markNeedsLayout();
  }

  List<ui.Image> get listIcon => _listIcon;

  set listIcon(List<ui.Image> value) {
    _listIcon = value.map((e) => e).toList();
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! NodeBoxData) {
      child.parentData = NodeBoxData();
    }
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    var child = firstChild;
    var position = 0;
    var looseConstraints = BoxConstraints.loose(constraints.biggest);
    while (child != null) {
      final node = child.parentData as NodeBoxData;

      child.layout(looseConstraints, parentUsesSize: true);
      graph.getNodeAtPosition(position).size = child.size;

      child = node.nextSibling;
      position++;
    }

    size = algorithm.run(graph, 0, 0);

    child = firstChild;
    position = 0;
    while (child != null) {
      final node = child.parentData as NodeBoxData;

      node.offset = graph.getNodeAtPosition(position).position;

      child = node.nextSibling;
      position++;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);

    algorithm.renderer?.render(context.canvas, graph, edgePaint);

    // if (_stateEdit) {
    //   context.canvas.drawImage(
    //       listIcon[0],
    //       Offset(graph.nodes[0].position.dx + graph.nodes[0].width / 2 - 30 / 2,
    //           graph.nodes[0].position.dy - 8 - 30),
    //       Paint()
    //         ..color = Colors.blue
    //         ..filterQuality = FilterQuality.high);
    //   graph.nodes.forEach((element) {
    //     // if (element.keyFather?.value == null) {
    //     //   context.canvas.drawImage(
    //     //       listIcon[0],
    //     //       Offset(element.position.dx + element.width / 2 - 30 / 2,
    //     //           element.position.dy - 8 - 30),
    //     //       Paint()
    //     //         ..color = Colors.blue
    //     //         ..filterQuality = FilterQuality.high);
    //     // }

    //     // draw icon delete
    //     context.canvas.drawImage(
    //         listIcon[0],
    //         Offset(element.position.dx + element.width / 2,
    //             element.position.dy + element.height + 8),
    //         Paint()
    //           ..color = Colors.blue
    //           ..filterQuality = FilterQuality.high);

    //     // draw icon add
    //     context.canvas.drawImage(
    //         listIcon[1],
    //         Offset(element.position.dx + element.width / 2 - 30,
    //             element.position.dy + element.height + 8),
    //         Paint()
    //           ..color = Colors.blue
    //           ..filterQuality = FilterQuality.high);
    //   });
    // }

    context.canvas.restore();

    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Graph>('graph', graph));
    properties.add(DiagnosticsProperty<Algorithm>('algorithm', algorithm));
    properties.add(DiagnosticsProperty<Paint>('paint', edgePaint));
  }
}

class NodeBoxData extends ContainerBoxParentData<RenderBox> {}

class _GraphViewAnimated extends StatefulWidget {
  final Graph graph;
  final Algorithm algorithm;
  final Paint? paint;
  final nodes = <Widget>[];
  final stepMilis = 25;

  _GraphViewAnimated(
      {Key? key,
      required this.graph,
      required this.algorithm,
      this.paint,
      required NodeWidgetBuilder builder}) {
    graph.nodes.forEach((node) {
      nodes.add(node.data ?? builder(node));
    });
  }

  @override
  _GraphViewAnimatedState createState() => _GraphViewAnimatedState();
}

class _GraphViewAnimatedState extends State<_GraphViewAnimated> {
  late Timer timer;
  late Graph graph;
  late Algorithm algorithm;

  @override
  void initState() {
    graph = widget.graph;

    algorithm = widget.algorithm;
    algorithm.init(graph);
    startTimer();

    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: widget.stepMilis), (timer) {
      algorithm.step(graph);
      update();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    algorithm.setDimensions(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: EdgeRender(algorithm, graph, Offset(20, 20)),
        ),
        ...List<Widget>.generate(graph.nodeCount(), (index) {
          return Positioned(
            child: GestureDetector(
              child: widget.nodes[index],
              onPanUpdate: (details) {
                graph.getNodeAtPosition(index).position += details.delta;
                update();
              },
            ),
            top: graph.getNodeAtPosition(index).position.dy,
            left: graph.getNodeAtPosition(index).position.dx,
          );
        }),
      ],
    );
  }

  Future<void> update() async {
    setState(() {});
  }
}

class EdgeRender extends CustomPainter {
  Algorithm algorithm;
  Graph graph;
  Offset offset;

  EdgeRender(this.algorithm, this.graph, this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    var edgePaint = (Paint()
      ..color = Colors.black
      ..strokeWidth = 3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    algorithm.renderer!.render(canvas, graph, edgePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
