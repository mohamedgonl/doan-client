part of graphview;

class Graph {
  final List<Node> _nodes = [];
  final List<Edge> _edges = [];
  List<GraphObserver> graphObserver = [];

  List<Node> get nodes => _nodes; //  List<Node> nodes = _nodes;
  List<Edge> get edges => _edges;

  var isTree = false;

  int nodeCount() => _nodes.length;

  void addNode(Node node) {
    // if (!_nodes.contains(node)) {
    _nodes.add(node);
    notifyGraphObserver();
    // }
  }

  void addNodes(List<Node> nodes) => nodes.forEach((it) => addNode(it));

  void removeNode(Node? node) {
    if (!_nodes.contains(node)) {
//            throw IllegalArgumentException("Unable to find node in graph.")
    }

    if (isTree) {
      successorsOf(node).forEach((element) => removeNode(element));
    }

    _nodes.remove(node);

    _edges
        .removeWhere((edge) => edge.source == node || edge.destination == node);

    notifyGraphObserver();
  }

  void removeNodes(List<Node> nodes) => nodes.forEach((it) => removeNode(it));

  Edge addEdge(Node source, Node destination, {Paint? paint}) {
    final edge = Edge(source, destination, paint: paint);
    addEdgeS(edge);

    return edge;
  }

  void addEdgeS(Edge edge) {
    var sourceSet = false;
    var destinationSet = false;
    _nodes.forEach((node) {
      if (!sourceSet && node == edge.source) {
        edge.source = node;
        sourceSet = true;
      } else if (!destinationSet && node == edge.destination) {
        edge.destination = node;
        destinationSet = true;
      }
    });
    if (!sourceSet) {
      _nodes.add(edge.source);
    }
    if (!destinationSet) {
      _nodes.add(edge.destination);
    }

    if (!_edges.contains(edge)) {
      _edges.add(edge);
      notifyGraphObserver();
    }
  }

  void addEdges(List<Edge> edges) => edges.forEach((it) => addEdgeS(it));

  void removeEdge(Edge edge) => _edges.remove(edge);

  void removeEdges(List<Edge> edges) => edges.forEach((it) => removeEdge(it));

  void removeEdgeFromPredecessor(Node? predecessor, Node? current) {
    _edges.removeWhere(
        (edge) => edge.source == predecessor && edge.destination == current);
  }

  bool hasNodes() => _nodes.isNotEmpty;

  Edge? getEdgeBetween(Node source, Node? destination) =>
      _edges.firstWhereOrNull((element) =>
          element.source == source && element.destination == destination);

  bool hasSuccessor(Node? node) =>
      _edges.any((element) => element.source == node);

  List<Node> successorsOf(Node? node) =>
      getOutEdges(node!).map((e) => e.destination).toList();

  bool hasPredecessor(Node node) =>
      _edges.any((element) => element.destination == node);

  List<Node> predecessorsOf(Node? node) =>
      getInEdges(node!).map((edge) => edge.source).toList();

  bool contains({Node? node, Edge? edge}) =>
      node != null && _nodes.contains(node) ||
      edge != null && _edges.contains(edge);

//  bool contains(Edge edge) => _edges.contains(edge);

  bool containsData(data) => _nodes.any((element) => element.data == data);

  Node getNodeAtPosition(int position) {
    if (position < 0) {
//            throw IllegalArgumentException("position can't be negative")
    }

    final size = _nodes.length;
    if (position >= size) {
//            throw IndexOutOfBoundsException("Position: $position, Size: $size")
    }

    return _nodes[position];
  }

  @Deprecated('Please use the builder and id mechanism to build the widgets')
  Node getNodeAtUsingData(Widget data) =>
      _nodes.firstWhere((element) => element.data == data);

  // Node getNodeUsingKey(ValueKey key) =>
  //     _nodes.firstWhere((element) => element.key == key);

  Node getNodeUsingId(dynamic id) =>
      _nodes.firstWhere((element) => element.memberId == id);

  List<Edge> getOutEdges(Node node) =>
      _edges.where((element) => element.source == node).toList();

  List<Edge> getInEdges(Node node) =>
      _edges.where((element) => element.destination == node).toList();

  void notifyGraphObserver() => graphObserver.forEach((element) {
        element.notifyGraphInvalidated();
      });

  String toJson() {
    var jsonString = {
      'nodes': [..._nodes.map((e) => e.hashCode.toString())],
      'edges': [
        ..._edges.map((e) => {
              'from': e.source.hashCode.toString(),
              'to': e.destination.hashCode.toString()
            })
      ]
    };

    return json.encode(jsonString);
  }
}

class Node {
  String? idTamThoi;
  int? depth;
  String? memberId; // id của node
  String? userId;
  String? giaPhaId;
  String? mid; // id của mẹ
  String? fid; // id của cha
  String? trangThai;
  String? ten;
  String? avatar;
  String? tenKhac;
  String? gioiTinh;
  String? ngaySinh;
  String? gioSinh;
  String? soDienThoai;
  String? email;
  String? trinhDo;
  String? nguyenQuan;
  String? diaChiHienTai;
  String? trangThaiMat;
  String? tieuSu;
  String? ngayMat;

  String? ngheNghiep;
  String? thoiGianTao;
  int? trangThaiNode;
  List<String>? pids; // list id vợ chồng
  String? pid; // id của thành viên trực hệ
  String? cid; // id của con
  int? root;

  @Deprecated('Please use the builder and id mechan ism to build the widgets')
  Widget? data;

  // @Deprecated('Please use the Node.Id')
  // Node(this.data, {Key? key}) {
  //   this.memberId = (key?.hashCode ?? data.hashCode).toString();
  // }

  Node({
    this.idTamThoi,
    this.depth,
    this.memberId,
    this.userId,
    this.giaPhaId,
    this.mid,
    this.fid,
    this.trangThai,
    this.ten,
    this.avatar,
    this.tenKhac,
    this.gioiTinh,
    this.ngaySinh,
    this.gioSinh,
    this.soDienThoai,
    this.email,
    this.trinhDo,
    this.nguyenQuan,
    this.diaChiHienTai,
    this.trangThaiMat,
    this.tieuSu,
    this.ngayMat,
    this.ngheNghiep,
    this.thoiGianTao,
    this.trangThaiNode,
    this.pids,
    this.pid,
    this.cid,
    this.root,
  });

  static UserInfo castMemberInfoFromNode(Node node) {
    return UserInfo(
      idTamThoi: node.idTamThoi,
      // ancestorId: node.ancestorId,
      // descendantId: node.descendantId,
      depth: node.depth,
      memberId: node.memberId,
      userId: node.userId,
      giaPhaId: node.giaPhaId,
      mid: node.mid,
      fid: node.fid,
      trangThai: node.trangThai,
      ten: node.ten,
      avatar: node.avatar,
      tenKhac: node.tenKhac,
      gioiTinh: node.gioiTinh,
      ngaySinh: node.ngaySinh,
      soDienThoai: node.soDienThoai,
      email: node.email,
      diaChiHienTai: node.diaChiHienTai,
      trangThaiMat: node.trangThaiMat,
      tieuSu: node.tieuSu,
      ngayMat: node.ngayMat,

      ngheNghiep: node.ngheNghiep,

      thoiGianTao: node.thoiGianTao,

      pid: node.pid,
      cid: node.cid,
      root: node.root,
    );
  }

  Size size = const Size(0, 0);

  Offset position = const Offset(0, 0);

  double get height => size.height;

  double get width => size.width;

  double get x => position.dx;

  double get y => position.dy;

  set y(double value) {
    position = Offset(position.dx, value);
  }

  set x(double value) {
    position = Offset(value, position.dy);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Node && hashCode == other.hashCode;

  @override
  int get hashCode {
    return memberId.hashCode;
  }

  @override
  String toString() {
    return 'Node{position: $position, key: $memberId, _size: $size}';
  }
}

class Edge {
  Node source;
  Node destination;

  Key? key;
  Paint? paint;

  Edge(this.source, this.destination, {this.key, this.paint});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is Edge && hashCode == other.hashCode;

  @override
  int get hashCode => key?.hashCode ?? Object.hash(source, destination);
}

abstract class GraphObserver {
  void notifyGraphInvalidated();
}
