// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../core/utils/shake_device_utils.dart';
// import 'network_event.dart';
// import 'network_logger_interceptor.dart';
// import 'network_logger_store.dart';

// typedef IndexBuilder = Widget Function(BuildContext context, int index);
// typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

// IndexBuilder enumerateItems<T>(List<T> items, ItemBuilder<T> builder) {
//   return (BuildContext context, int index) => builder(context, items[index]);
// }

// class NetworkLoggerUtils {
//   factory NetworkLoggerUtils() {
//     return _instance;
//   }
//   NetworkLoggerUtils._();

//   static final NetworkLoggerUtils _instance = NetworkLoggerUtils._();
//   // ShakeDetector? detector;
//   bool _isShowing = false;
//   bool _isEnable = false;

//   void init({bool? isEnable, int? maxRequests}) {
//     _isEnable = isEnable ?? false;
//     NetworkLoggerStore().setMaxRequests = maxRequests ?? 50;
//     NetworkLoggerInterceptor().setIsEnabled = isEnable ?? false;
//   }

//   void start(BuildContext context) {
//     if (!_isEnable) {
//       return;
//     }
//     detector ??= ShakeDetector.autoStart(onPhoneShake: () {
//       if (_isShowing) {
//         return;
//       }
//       try {
//         _isShowing = true;
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => NetworkLoggerScreen()),
//         ).then((_) => _isShowing = false);
//       } catch (e) {
//         _isShowing = false;
//       }
//     });
//   }

//   void close() {
//     detector?.stopListening();
//   }
// }

// /// Screen that displays log entries list.
// class NetworkLoggerScreen extends StatelessWidget {
//   final NetworkLoggerStore store = NetworkLoggerStore();

//   NetworkLoggerScreen({Key? key}) : super(key: key);

//   final TextEditingController searchController =
//       TextEditingController(text: null);

//   /// filte events with search keyword
//   List<NetworkEvent> getEvents() {
//     if (searchController.text.isEmpty) {
//       return store.events;
//     }
//     final query = searchController.text.toLowerCase();
//     return store.events
//         .where((it) => it.request?.uri.toLowerCase().contains(query) ?? false)
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _padding = MediaQuery.of(context).padding;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.only(top: _padding.top, bottom: _padding.bottom),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const Icon(Icons.arrow_back),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'Network Logger',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: store.clear,
//                     icon: const Icon(Icons.delete),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                   stream: store.stream,
//                   builder: (context, snapshot) {
//                     final events = getEvents();
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 5),
//                           child: TextField(
//                             controller: searchController,
//                             onChanged: (text) {
//                               store.updated(NetworkEvent());
//                             },
//                             autocorrect: false,
//                             textAlignVertical: TextAlignVertical.center,
//                             decoration: InputDecoration(
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Colors.black26,
//                               ),
//                               suffix: Text('${getEvents().length} results'),
//                               hintText: 'Enter URL to search',
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: ListView.separated(
//                             padding: EdgeInsets.zero,
//                             itemCount: events.length,
//                             separatorBuilder: (_, index) =>
//                                 const Divider(height: 1),
//                             itemBuilder: enumerateItems<NetworkEvent>(
//                               events,
//                               (context, item) => _LoggerItem(
//                                 key: ValueKey(item.request),
//                                 data: item,
//                                 onTap: () => NetworkLoggerEventScreen.open(
//                                   context,
//                                   item,
//                                   store,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LoggerItem extends StatelessWidget {
//   final NetworkEvent data;
//   final VoidCallback onTap;

//   const _LoggerItem({
//     Key? key,
//     required this.data,
//     required this.onTap,
//   }) : super(key: key);

//   Color _statusColor(int? statusCode) {
//     if (statusCode == null) {
//       return Colors.black;
//     }
//     if (statusCode < 0) {
//       return Colors.white;
//     }
//     if (statusCode < 400) {
//       return Colors.green;
//     }
//     if (statusCode < 500) {
//       return Colors.amber;
//     }
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 80,
//               child: Column(
//                 children: [
//                   Text(
//                     data.request!.method,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                   if (data.response?.statusCode != null)
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 5),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 1, horizontal: 5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: _statusColor(data.response!.statusCode),
//                         ),
//                       ),
//                       child: Text(
//                         data.response!.statusCode.toString(),
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: _statusColor(data.response!.statusCode),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 data.request!.uri,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: _statusColor(data.response?.statusCode),
//                 ),
//                 maxLines: 4,
//               ),
//             ),
//             const SizedBox(width: 15)
//           ],
//         ),
//       ),
//     );
//   }
// }

// String _timeDifference({DateTime? endTime, DateTime? startTime}) {
//   if (endTime == null || startTime == null) {
//     return '-';
//   }
//   final delta = endTime.difference(startTime);
//   if (delta.inMilliseconds < 1000) {
//     return '${delta.inMilliseconds}ms';
//   } else if (delta.inSeconds < 90) {
//     return '${delta.inSeconds}s';
//   } else if (delta.inMinutes < 90) {
//     return '${delta.inMinutes}m';
//   } else {
//     return '${delta.inHours}h';
//   }
// }

// const _jsonEncoder = JsonEncoder.withIndent('  ');

// String _jsonToString(Map value) =>
//     const JsonEncoder().convert(value).replaceAll(RegExp(r'[\\]"'), '"');

// /// Screen that displays log entry details.
// class NetworkLoggerEventScreen extends StatelessWidget {
//   const NetworkLoggerEventScreen({Key? key, required this.event})
//       : super(key: key);

//   /// Opens screen.
//   static Future<void> open(
//     BuildContext context,
//     NetworkEvent event,
//     NetworkLoggerStore store,
//   ) {
//     return Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StreamBuilder(
//           stream: store.stream.where((item) => item.event == event),
//           builder: (context, snapshot) =>
//               NetworkLoggerEventScreen(event: event),
//         ),
//       ),
//     );
//   }

//   /// Which event to display details for.
//   final NetworkEvent event;

//   Map<String, String> get _getRequestMap {
//     final _request = Map.fromEntries([
//       MapEntry('Method', event.request!.method),
//       MapEntry('Url', event.request!.uri),
//       MapEntry('Start-time', event.startTime?.toIso8601String() ?? '-'),
//       MapEntry('Duration',
//           _timeDifference(endTime: event.endTime, startTime: event.startTime)),
//       MapEntry('Status-code', event.response?.statusCode.toString() ?? ''),
//     ]);
//     if (event.error != null) {
//       _request.putIfAbsent('Message', () => event.error?.toString() ?? '');
//     }
//     return _request;
//   }

//   String _getDataString(dynamic body) {
//     String text;
//     if (body == null) {
//       text = '';
//     } else if (body is String) {
//       text = body;
//     } else if (body is List || body is Map) {
//       text = _jsonEncoder.convert(body);
//     } else {
//       text = body.toString();
//     }
//     return text;
//   }

//   String get _requestToCopy => _jsonToString(_getRequestMap);

//   String get _requestHeaderToCopy =>
//       _jsonToString(Map.fromEntries(event.request?.headers.entries ?? []));

//   String get _requestBodyToCopy => _jsonToString(event.request?.data ?? {});

//   String get _responseHeaderToCopy =>
//       _jsonToString(Map.fromEntries(event.response?.headers.entries ?? []));

//   String get _responseBodyToCopy => _jsonToString(event.response?.data ?? {});

//   void _copyAll(BuildContext context) {
//     _excuteCopy(context, '''
//     {
//       "Request": $_requestToCopy,
//       "Request-Header": $_requestHeaderToCopy,
//       "Request-Body": $_requestBodyToCopy,
//       "Response-Header": $_responseHeaderToCopy,
//       "Response-Body": $_responseBodyToCopy
//     }
//     ''');
//   }

//   void _excuteCopy(BuildContext context, String text) {
//     Clipboard.setData(ClipboardData(text: text));
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Copied to clipboard'),
//       behavior: SnackBarBehavior.floating,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _padding = MediaQuery.of(context).padding;
//     return Theme(
//       data: ThemeData().copyWith(dividerColor: Colors.transparent),
//       child: ListTileTheme(
//         dense: true,
//         child: Scaffold(
//           body: Padding(
//             padding:
//                 EdgeInsets.only(top: _padding.top, bottom: _padding.bottom),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         icon: const Icon(Icons.arrow_back),
//                       ),
//                       const Expanded(
//                         child: Text(
//                           'Entry Details',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           _copyAll(context);
//                         },
//                         icon: const Icon(Icons.copy_all),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(height: 1, color: Colors.grey),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onLongPress: () =>
//                               _excuteCopy(context, _requestToCopy),
//                           child: ExpansionTile(
//                             collapsedBackgroundColor: Colors.grey[100],
//                             title: const _EntryCategory(title: 'Request'),
//                             childrenPadding: const EdgeInsets.only(bottom: 10),
//                             textColor: Colors.black,
//                             initiallyExpanded: true,
//                             expandedCrossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               const Divider(height: 1, color: Colors.grey),
//                               const SizedBox(height: 5),
//                               ..._getRequestMap.entries
//                                   .map((e) =>
//                                       _EntryValue(title: e.key, value: e.value))
//                                   .toList()
//                             ],
//                           ),
//                         ),
//                         const Divider(height: 1, color: Colors.grey),
//                         GestureDetector(
//                           onLongPress: () =>
//                               _excuteCopy(context, _requestHeaderToCopy),
//                           child: ExpansionTile(
//                             collapsedBackgroundColor: Colors.grey[100],
//                             title:
//                                 const _EntryCategory(title: 'Request Headers'),
//                             childrenPadding: const EdgeInsets.only(bottom: 10),
//                             textColor: Colors.black,
//                             expandedCrossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               const Divider(height: 1, color: Colors.grey),
//                               const SizedBox(height: 5),
//                               ...event.request!.headers.entries
//                                   .map((e) =>
//                                       _EntryValue(title: e.key, value: e.value))
//                                   .toList()
//                             ],
//                           ),
//                         ),
//                         if (_getDataString(event.request!.data).isNotEmpty) ...[
//                           const Divider(height: 1, color: Colors.grey),
//                           GestureDetector(
//                             onLongPress: () =>
//                                 _excuteCopy(context, _requestBodyToCopy),
//                             child: ExpansionTile(
//                               collapsedBackgroundColor: Colors.grey[100],
//                               title:
//                                   const _EntryCategory(title: 'Request Body'),
//                               childrenPadding:
//                                   const EdgeInsets.only(bottom: 10),
//                               initiallyExpanded: true,
//                               textColor: Colors.black,
//                               expandedCrossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 const Divider(height: 1, color: Colors.grey),
//                                 const SizedBox(height: 5),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 5),
//                                   child:
//                                       Text(_getDataString(event.request!.data)),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                         if (event.response?.headers.entries.isNotEmpty ??
//                             false) ...[
//                           const Divider(height: 1, color: Colors.grey),
//                           GestureDetector(
//                             onLongPress: () =>
//                                 _excuteCopy(context, _responseHeaderToCopy),
//                             child: ExpansionTile(
//                               collapsedBackgroundColor: Colors.grey[100],
//                               title: const _EntryCategory(
//                                   title: 'Response Headers'),
//                               childrenPadding:
//                                   const EdgeInsets.only(bottom: 10),
//                               textColor: Colors.black,
//                               expandedCrossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 const Divider(height: 1, color: Colors.grey),
//                                 const SizedBox(height: 5),
//                                 ...event.response!.headers.entries
//                                     .map((e) => _EntryValue(
//                                         title: e.key, value: e.value))
//                                     .toList()
//                               ],
//                             ),
//                           )
//                         ],
//                         if (_getDataString(event.response?.data)
//                             .isNotEmpty) ...[
//                           const Divider(height: 1, color: Colors.grey),
//                           GestureDetector(
//                             onLongPress: () =>
//                                 _excuteCopy(context, _responseBodyToCopy),
//                             child: ExpansionTile(
//                               collapsedBackgroundColor: Colors.grey[100],
//                               title:
//                                   const _EntryCategory(title: 'Response Body'),
//                               childrenPadding:
//                                   const EdgeInsets.only(bottom: 10),
//                               initiallyExpanded: true,
//                               expandedCrossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               textColor: Colors.black,
//                               children: [
//                                 const Divider(height: 1, color: Colors.grey),
//                                 const SizedBox(height: 5),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 5),
//                                   child: Text(
//                                       _getDataString(event.response!.data)),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                         const Divider(height: 1, color: Colors.grey),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EntryCategory extends StatelessWidget {
//   final String title;

//   const _EntryCategory({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//     );
//   }
// }

// class _EntryValue extends StatelessWidget {
//   final String title;
//   final String value;

//   const _EntryValue({
//     Key? key,
//     required this.title,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 110,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Text(value),
//           )
//         ],
//       ),
//     );
//   }
// }
