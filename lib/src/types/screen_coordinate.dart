// Copyright 2020 The yjpark. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show hashValues;

import 'package:meta/meta.dart' show immutable;

/// Represents a point coordinate in the [KakaoMap]'s view.
///
/// The screen location is specified in screen pixels (not display pixels) relative
/// to the top left of the map, not top left of the whole screen. (x, y) = (0, 0)
/// corresponds to top-left of the [KakaoMap] not the whole screen.
@immutable
class ScreenCoordinate {
  /// Creates an immutable representation of a point coordinate in the [KakaoMap]'s view.
  const ScreenCoordinate({
    required this.x,
    required this.y,
  });

  /// Represents the number of pixels from the left of the [KakaoMap].
  final int x;

  /// Represents the number of pixels from the top of the [KakaoMap].
  final int y;

  /// Converts this object to something serializable in JSON.
  dynamic toJson() {
    return <String, int>{
      "x": x,
      "y": y,
    };
  }

  @override
  String toString() => '$runtimeType($x, $y)';

  @override
  bool operator ==(Object o) {
    return o is ScreenCoordinate && o.x == x && o.y == y;
  }

  @override
  int get hashCode => hashValues(x, y);
}
