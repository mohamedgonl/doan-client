part of graphview;

class TreeEdgeRenderer extends EdgeRenderer {
  BuchheimWalkerConfiguration configuration;
  TreeEdgeRenderer(this.configuration);

  var linePath = Path();

  @override
  void render(Canvas canvas, Graph graph, Paint paint,
      {bool stateEdit = false}) {
    var levelSeparationHalf = (configuration.levelSeparation) / 2;
    var siblingSeparation = configuration.siblingSeparation;

    graph.nodes.forEach((node) {
      var children = graph.successorsOf(node);

      children.forEach((child) {
        var edge = graph.getEdgeBetween(node, child);
        var edgePaint = (edge?.paint ?? paint)..style = PaintingStyle.stroke;
        linePath.reset();

        switch (configuration.orientation) {
          case BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM:
            {
              // position at the middle-top of the child
              linePath.moveTo((child.x + child.width / 2), child.y + 38);
              // draws a line from the child's middle-top halfway up to its parent
              linePath.lineTo(
                  child.x + child.width / 2, child.y - levelSeparationHalf);
              // draws a line from the previous point to the middle of the parents width
              linePath.lineTo(
                  node.x + node.width / 2, child.y - levelSeparationHalf);

              // position at the middle of the level separation under the parent
              linePath.moveTo(
                  node.x + node.width / 2, child.y - levelSeparationHalf);
              // draws a line up to the parents middle-bottom
              linePath.lineTo(
                  node.x + node.width / 2, node.y + node.height - 38);
            }

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP:
            linePath.moveTo(child.x + child.width / 2, child.y + child.height);
            linePath.lineTo(child.x + child.width / 2,
                child.y + child.height + levelSeparationHalf);
            linePath.lineTo(node.x + node.width / 2,
                child.y + child.height + levelSeparationHalf);

            linePath.moveTo(node.x + node.width / 2,
                child.y + child.height + levelSeparationHalf);
            linePath.lineTo(node.x + node.width / 2, node.y + node.height);

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT:
            linePath.moveTo(child.x, child.y + child.height / 2);
            linePath.lineTo(
                child.x - levelSeparationHalf, child.y + child.height / 2);
            linePath.lineTo(
                child.x - levelSeparationHalf, node.y + node.height / 2);

            linePath.moveTo(
                child.x - levelSeparationHalf, node.y + node.height / 2);
            linePath.lineTo(node.x + node.width, node.y + node.height / 2);

            break;
          case BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT:
            linePath.moveTo(child.x + child.width, child.y + child.height / 2);
            linePath.lineTo(child.x + child.width + levelSeparationHalf,
                child.y + child.height / 2);
            linePath.lineTo(child.x + child.width + levelSeparationHalf,
                node.y + node.height / 2);

            linePath.moveTo(child.x + child.width + levelSeparationHalf,
                node.y + node.height / 2);
            linePath.lineTo(node.x + node.width, node.y + node.height / 2);
        }
        canvas.drawPath(linePath, edgePaint);
      });

      if (node.pids != null && node.pids!.isNotEmpty) {
        int lengthPid = 0;
        for (var element in node.pids!) {
          if (!element.contains("da_xoa")) {
            lengthPid = 1;
          }
        }
        linePath.reset();
        linePath.moveTo(node.x + 38, node.y + node.height / 2);
        linePath.lineTo(
            node.x + (node.width + siblingSeparation) * lengthPid + 38,
            node.y + node.height / 2);
        canvas.drawPath(
            linePath,
            Paint()
              ..color = const Color(0xffD8D8D8)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4);
      }
    });
  }
}
