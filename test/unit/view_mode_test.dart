import 'package:color_blind_filter/models/view_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewMode enum', () {
    test('has exactly 2 values', () {
      expect(ViewMode.values.length, 2);
    });

    test('contains fullScreen and splitView', () {
      expect(ViewMode.values, contains(ViewMode.fullScreen));
      expect(ViewMode.values, contains(ViewMode.splitView));
    });
  });

  group('ViewMode icon', () {
    test('fullScreen returns view_column icon', () {
      expect(ViewMode.fullScreen.icon, Icons.view_column);
    });

    test('splitView returns fullscreen icon', () {
      expect(ViewMode.splitView.icon, Icons.fullscreen);
    });
  });

  group('ViewMode label', () {
    test('fullScreen returns "Full Screen"', () {
      expect(ViewMode.fullScreen.label, 'Full Screen');
    });

    test('splitView returns "Split View"', () {
      expect(ViewMode.splitView.label, 'Split View');
    });
  });

  group('ViewMode toggled', () {
    test('fullScreen toggles to splitView', () {
      expect(ViewMode.fullScreen.toggled, ViewMode.splitView);
    });

    test('splitView toggles to fullScreen', () {
      expect(ViewMode.splitView.toggled, ViewMode.fullScreen);
    });

    test('double toggle returns original', () {
      expect(ViewMode.fullScreen.toggled.toggled, ViewMode.fullScreen);
      expect(ViewMode.splitView.toggled.toggled, ViewMode.splitView);
    });
  });
}
