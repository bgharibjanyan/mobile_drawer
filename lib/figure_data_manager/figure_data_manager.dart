import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class FigureData {
  Offset? currentPosition;

  final double circlePointerRadius;
  final Color circlePointerColor;

  final bool figureCreated;

  final List<Offset> circlePositions;
  final int currentCircleIndex;

  final bool intersectionsExist;

  FigureData({
    List<Offset>? circlePositions,
    this.currentPosition,
    this.circlePointerRadius = 8.5,
    this.circlePointerColor = const Color(0xFFE3E3E3),
    this.figureCreated = false,
    this.currentCircleIndex = 0,
    this.intersectionsExist = false,
  }) : circlePositions = circlePositions ?? [];

  FigureData copyWith({
    Offset? currentPosition,
    Offset? dropPosition,
    double? circlePointerRadius,
    Color? circlePointerColor,
    bool? figureCreated,
    List<Offset>? circlePositions,
    int? currentCircleIndex,
    bool? intersectionsExist,
  }) {
    return FigureData(
      currentPosition: currentPosition ?? this.currentPosition,
      circlePointerRadius: circlePointerRadius ?? this.circlePointerRadius,
      circlePointerColor: circlePointerColor ?? this.circlePointerColor,
      figureCreated: figureCreated ?? this.figureCreated,
      intersectionsExist: intersectionsExist ?? this.intersectionsExist,
      circlePositions: circlePositions ?? this.circlePositions,
      currentCircleIndex: currentCircleIndex ?? this.currentCircleIndex,
    );
  }
}

class FigureDataNotifier extends StateNotifier<FigureData> {
  FigureDataNotifier(super.state);

  void updateCurrentPosition(Offset newPosition) {
    state = state.copyWith(currentPosition: newPosition);
  }

  void updateCirclePointerRadius(double newRadius) {
    state = state.copyWith(circlePointerRadius: newRadius);
  }

  void updateCirclePointerColor(Color newColor) {
    state = state.copyWith(circlePointerColor: newColor);
  }

  void updateFigureCreated(bool newFigureCreated) {
    state = state.copyWith(figureCreated: newFigureCreated);
  }

  void updateInsertionsExist(bool newInsertionCheck) {
    state = state.copyWith(intersectionsExist: newInsertionCheck);
  }

  void updateCirclePositions(List<Offset> newCirclePositions) {
    state = state.copyWith(circlePositions: newCirclePositions);
  }

  void updateCurrentCircleIndex(int newIndex) {
    state = state.copyWith(currentCircleIndex: newIndex);
  }

  void updatePositionOffset(int positionIndex, Offset newPosition) {
    if (positionIndex < 0 || positionIndex >= state.circlePositions.length) {
      return;
    }

    List<Offset> updatedPositions = List<Offset>.from(state.circlePositions);
    updatedPositions[positionIndex] = newPosition;

    state = state.copyWith(circlePositions: updatedPositions);
  }

  void addPositionOffset(Offset newPosition) {

    List<Offset> updatedPositions = List<Offset>.from(state.circlePositions);
    updatedPositions.add(newPosition);

    state = state.copyWith(circlePositions: updatedPositions);
  }

  void clearOffsets() {
    state = state.copyWith(circlePositions: []);
    state = state.copyWith(figureCreated: false);
  }
}
