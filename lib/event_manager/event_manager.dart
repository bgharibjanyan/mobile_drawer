import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geometry_task/main.dart';

class FigureEventManager {
  final WidgetRef ref;

  FigureEventManager(this.ref);

  void penStartDefault(details) {
    ref
        .read(figureDataProvider.notifier)
        .updateCirclePointerColor(const Color(0xFFFDFDFD));
    ref.read(figureDataProvider.notifier).updateCurrentCircleIndex(
        ref.watch(figureDataProvider).circlePositions.length);

    for (int i = 0;
        i < ref.watch(figureDataProvider).circlePositions.length;
        i++) {
      if ((ref.watch(figureDataProvider).circlePositions[i].dx -
                  details.localPosition.dx) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dx -
                  details.localPosition.dx) >
              -25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dy -
                  details.localPosition.dy) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dy -
                  details.localPosition.dy) >
              -25) {
        ref.read(figureDataProvider.notifier).updateCurrentCircleIndex(i);
        break;
      }
    }

    if (ref.watch(figureDataProvider).currentCircleIndex ==
            ref.watch(figureDataProvider).circlePositions.length &&
        !ref.watch(figureDataProvider).figureCreated) {
      ref
          .read(figureDataProvider.notifier)
          .addPositionOffset(details.localPosition);
    }
    ref
        .read(figureDataProvider.notifier)
        .updateCurrentPosition(details.localPosition);
  }

  void penStartFigureCreated(details) {
    ref
        .read(figureDataProvider.notifier)
        .updateCirclePointerColor(const Color(0xFFFDFDFD));

    ref.read(figureDataProvider.notifier).updateCurrentCircleIndex(
        ref.watch(figureDataProvider).circlePositions.length);

    for (int i = 0;
        i < ref.watch(figureDataProvider).circlePositions.length;
        i++) {
      if ((ref.watch(figureDataProvider).circlePositions[i].dx -
                  details.localPosition.dx) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dx -
                  details.localPosition.dx) >
              -25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dy -
                  details.localPosition.dy) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[i].dy -
                  details.localPosition.dy) >
              -25) {
        ref.read(figureDataProvider.notifier).updateCurrentCircleIndex(i);
        break;
      }
    }
    ref
        .read(figureDataProvider.notifier)
        .updateCurrentPosition(details.localPosition);
  }

  void penUpdateFigureCreated(details) {
    analyzeIntersections();

    int firstElementIndex = 0;
    int lastElementIndex =
        ref.watch(figureDataProvider).circlePositions.length - 1;

    if (ref.watch(figureDataProvider).currentCircleIndex == firstElementIndex ||
        ref.watch(figureDataProvider).currentCircleIndex == lastElementIndex) {
      ref
          .read(figureDataProvider.notifier)
          .updatePositionOffset(firstElementIndex, details.localPosition);
      ref
          .read(figureDataProvider.notifier)
          .updatePositionOffset(lastElementIndex, details.localPosition);
    } else {
      ref.read(figureDataProvider.notifier).updatePositionOffset(
          ref.watch(figureDataProvider).currentCircleIndex,
          details.localPosition);
    }

    ref
        .read(figureDataProvider.notifier)
        .updateCurrentPosition(details.localPosition);
  }

  void penUpdateDefault(details) {
    analyzeIntersections();
    ref.read(figureDataProvider.notifier).updatePositionOffset(
        ref.watch(figureDataProvider).currentCircleIndex,
        details.localPosition);
    ref
        .read(figureDataProvider.notifier)
        .updateCurrentPosition(details.localPosition);
  }

  void penEndDefault(details) {
    ref
        .read(figureDataProvider.notifier)
        .updateCirclePointerColor(const Color(0xFF0098EE));

    int minAnglesCount = 2;
    int firstElementIndex = 0;
    int lastElementIndex =
        ref.watch(figureDataProvider).circlePositions.length - 1;

    if (ref.watch(figureDataProvider).circlePositions.length >=
        minAnglesCount) {
      if ((ref.watch(figureDataProvider).circlePositions[firstElementIndex].dx -
                  ref
                      .watch(figureDataProvider)
                      .circlePositions[lastElementIndex]
                      .dx) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[firstElementIndex].dx -
                  ref
                      .watch(figureDataProvider)
                      .circlePositions[lastElementIndex]
                      .dx) >
              -25 &&
          (ref.watch(figureDataProvider).circlePositions[firstElementIndex].dy -
                  ref
                      .watch(figureDataProvider)
                      .circlePositions[lastElementIndex]
                      .dy) <
              25 &&
          (ref.watch(figureDataProvider).circlePositions[firstElementIndex].dy -
                  ref
                      .watch(figureDataProvider)
                      .circlePositions[lastElementIndex]
                      .dy) >
              -25) {
        onFigureCreate();
      }
    }
  }

  void penEndFigureCreated(details) {
    print('figure already created');
  }

  void onFigureCreate() {
    int firstElementIndex = 0;
    int lastElementIndex =
        ref.watch(figureDataProvider).circlePositions.length - 1;

    ref.read(figureDataProvider.notifier).updateFigureCreated(true);
    ref.read(figureDataProvider.notifier).updatePositionOffset(lastElementIndex,
        ref.watch(figureDataProvider).circlePositions[firstElementIndex]);
  }

  bool doLinesIntersect(
      Offset line1Start, Offset line1End, Offset line2Start, Offset line2End) {
    double d1 =
        (line1End.dx - line1Start.dx) * (line2Start.dy - line1Start.dy) -
            (line1End.dy - line1Start.dy) * (line2Start.dx - line1Start.dx);
    double d2 = (line1End.dx - line1Start.dx) * (line2End.dy - line1Start.dy) -
        (line1End.dy - line1Start.dy) * (line2End.dx - line1Start.dx);
    double d3 =
        (line2End.dx - line2Start.dx) * (line1Start.dy - line2Start.dy) -
            (line2End.dy - line2Start.dy) * (line1Start.dx - line2Start.dx);
    double d4 = (line2End.dx - line2Start.dx) * (line1End.dy - line2Start.dy) -
        (line2End.dy - line2Start.dy) * (line1End.dx - line2Start.dx);

    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
      return true;
    } else if (d1 == 0 && onSegment(line1Start, line2Start, line1End)) {
      return true;
    } else if (d2 == 0 && onSegment(line1Start, line2End, line1End)) {
      return true;
    } else if (d3 == 0 && onSegment(line2Start, line1Start, line2End)) {
      return true;
    } else if (d4 == 0 && onSegment(line2Start, line1End, line2End)) {
      return true;
    }
    return false;
  }

  bool onSegment(Offset p, Offset q, Offset r) {
    if (q.dx <= max(p.dx, r.dx) &&
        q.dx >= min(p.dx, r.dx) &&
        q.dy <= max(p.dy, r.dy) &&
        q.dy >= min(p.dy, r.dy)) {
      return true;
    }
    return false;
  }

  void analyzeIntersections() {
    List<Offset> points = ref.watch(figureDataProvider).circlePositions;
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length - 1; j++) {
        if (j != i + 1 && !(i == 0 && j == points.length - 2)) {
          if (doLinesIntersect(points[i], points[(i + 1) % points.length],
              points[j], points[(j + 1) % points.length])) {
            ref.read(figureDataProvider.notifier).updateInsertionsExist(true);
            return;
          }
        }
      }
    }
    ref.read(figureDataProvider.notifier).updateInsertionsExist(false);
  }
}
