import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geometry_task/figure_data_manager/figure_data_manager.dart';
import 'package:geometry_task/main_screen/main_screen.dart';

final figureDataProvider = StateNotifierProvider<FigureDataNotifier,FigureData>((ref) => FigureDataNotifier(FigureData(currentPosition: Offset(0,0))));


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyAgipp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragAndDropScreen(),
    );
  }
}
