import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geometry_task/bottom_bar/bottom_bar.dart';
import 'package:geometry_task/circle_line_pointer/connection_line_pointer.dart';
import 'package:geometry_task/circle_poiner/circle_poiner.dart';
import 'package:geometry_task/event_manager/event_manager.dart';
import 'package:geometry_task/figure_data_manager/figure_data_manager.dart';
import 'package:geometry_task/figure_painter/figure_painter.dart';
import 'package:geometry_task/gesture_background/gesture_background.dart';
import 'package:geometry_task/main.dart';

class DragAndDropScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final figureData = ref.watch(figureDataProvider) as FigureData;
    final events = FigureEventManager(ref);

    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(
        message: 'Нажмите на любую точку экрана, чтобы построить угол',
      ),
      backgroundColor: const Color(0xFFE3E3E3),
      appBar: AppBar(
        title: const Text('Drag and Drop Circle'),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          figureData.figureCreated
              ? events.penStartFigureCreated(details)
              : events.penStartDefault(details);
        },
        onPanUpdate: (details) {
          figureData.figureCreated
              ? events.penUpdateFigureCreated(details)
              : events.penUpdateDefault(details);
        },
        onPanEnd: (details) {
          figureData.figureCreated
              ? events.penEndFigureCreated(details)
              : events.penEndDefault(details);
        },
        child: Stack(
          children: [
            CustomPaint(
              painter: DottedBackgroundPainter(),
              child: Container(),
            ),
            if (figureData.figureCreated) ...[
              CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter:
                    GrowingFigurePainter(points: figureData.circlePositions),
              ),
            ],
            CustomPaint(
              size: Size.infinite,
              painter: ConnectionLinesPainter(figureData.circlePositions, figureData.intersectionsExist),
            ),
            for (var i = 0; i < figureData.circlePositions.length; i++)
              CustomPaint(
                size: Size.infinite,
                painter: CirclePointer(
                    figureData.circlePositions[i],
                    figureData.circlePointerRadius,
                    figureData.circlePointerColor),
              ),
          ],
        ),
      ),
    );
  }
}
