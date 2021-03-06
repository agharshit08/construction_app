import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_app/model/drawing_model.dart';
import 'package:construction_app/screens/add_drawing.dart';
import 'package:construction_app/size_config.dart';
import 'package:construction_app/widgets/drawing_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    /// Init size config based on portrait mode height and width.
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawings'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        /// Connect to drawings stored in Firestore and listen to any Create, Update, Delete changes in Firestore.
        stream: FirebaseFirestore.instance
            .collection('drawings')
            .orderBy('time')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          /// Convert the fetched docs to Docs based in Drawing Model.
          List<DrawingModel> fetchedDocs = snapshot.data.docs.map((doc) {
            return DrawingModel(
              drawingId: doc.id,
              imageUrl: doc['imageUrl'],
              markers: doc['markers'],
              time: doc['time'],
              title: doc['title'],
            );
          }).toList();

          // Reverse the documents to show most recent drawing at top.
          List<DrawingModel> listOfDrawings = List.from(fetchedDocs.reversed);

          return listOfDrawings.length > 0
              ? Container(
                  height: SizeConfig.blockSizeVertical * 85, // set height to 85% of screen height.
                  child: ListView.builder(
                    itemCount: listOfDrawings.length,
                    itemBuilder: (BuildContext context, int index) =>
                        DrawingCardWidget(listOfDrawings[index]),
                  ),
                )
              : Center(
                  child: Text('No drawings found'),
                );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddDrawingScreen.routeName);
        },
      ),
    );
  }
}
