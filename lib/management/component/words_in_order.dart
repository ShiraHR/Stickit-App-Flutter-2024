// import 'package:flutter/material.dart';


// class DraggableWords extends StatefulWidget {
//   final String sentence;

//   DraggableWords({required this.sentence});

//   @override
//   _DraggableWordsState createState() => _DraggableWordsState();
// }

// class _DraggableWordsState extends State<DraggableWords> {
//   late List<String> words;

//   @override
//   void initState() {
//     super.initState();
//     words = widget.sentence.split(' ');
//   }

//   @override
//   Widget _answerWordInOrder(BuildContext context) {
//     return Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: List.generate(
//               words.length,
//               (index) {
//                 return Draggable<String>(
//                   data: words[index],
//                   feedback: Material(
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         border: Border.all(color: Colors.blue),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: IntrinsicWidth(
//                         child: IntrinsicHeight(
//                           child: Center(
//                             child: Text(words[index]),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   childWhenDragging: Container(),
//                   child: DragTarget<String>(
//                     onAccept: (data) {
//                       setState(() {
//                         int oldIndex = words.indexOf(data);
//                         String item = words.removeAt(oldIndex);
//                         words.insert(index, item);
//                       });
//                     },
//                     builder: (context, candidateData, rejectedData) {
//                       return Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           border: Border.all(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: IntrinsicWidth(
//                           child: IntrinsicHeight(
//                             child: Center(
//                               child: Text(words[index]),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
    
//   }
// }