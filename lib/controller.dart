// Copyright 2020 The yjpark. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of flutter_kakao_map;

final KakaoMapsFlutterPlatform _kakaoMapsFlutterPlatform =
    KakaoMapsFlutterPlatform.instance;

/// Controller for a single KakaoMap instance running on the host platform.
class KakaoMapController {
  /// The mapId for this controller
  final int mapId;

  KakaoMapController._(
    CameraPosition initialCameraPosition,
    this._kakaoMapState, {
    required this.mapId,
  }) {
    _connectStreams(mapId);
  }

  /// Initialize control of a [KakaoMap] with [id].
  ///
  /// Mainly for internal use when instantiating a [KakaoMapController] passed
  /// in [KakaoMap.onMapCreated] callback.
  static Future<KakaoMapController> init(
    int id,
    CameraPosition initialCameraPosition,
    _KakaoMapState kakaoMapState,
  ) async {
    await _kakaoMapsFlutterPlatform.init(id);
    return KakaoMapController._(
      initialCameraPosition,
      kakaoMapState,
      mapId: id,
    );
  }

  /// Used to communicate with the native platform.
  ///
  /// Accessible only for testing.
  // TODO(dit) https://github.com/flutter/flutter/issues/55504 Remove this getter.
  @visibleForTesting
  MethodChannel? get channel {
    if (_kakaoMapsFlutterPlatform is MethodChannelKakaoMapsFlutter) {
      return (_kakaoMapsFlutterPlatform as MethodChannelKakaoMapsFlutter)
          .channel(mapId);
    }
    return null;
  }

  final _KakaoMapState _kakaoMapState;

  void _connectStreams(int mapId) {
    if (_kakaoMapState.widget.onCameraMoveStarted != null) {
      _kakaoMapsFlutterPlatform
          .onCameraMoveStarted(mapId: mapId)
          .listen((_) => _kakaoMapState.widget.onCameraMoveStarted!());
    }
    if (_kakaoMapState.widget.onCameraMove != null) {
      _kakaoMapsFlutterPlatform
          .onCameraMove(mapId: mapId)
          .listen((e) => {_kakaoMapState.widget.onCameraMove!(e.value)});
    }
    if (_kakaoMapState.widget.onCurrentLocationUpdate != null) {
      _kakaoMapsFlutterPlatform.onCurrentLocationUpdate(mapId: mapId).listen(
          (e) => {_kakaoMapState.widget.onCurrentLocationUpdate!(e.value)});
    }

    if (_kakaoMapState.widget.onMarkerSelect != null) {
      _kakaoMapsFlutterPlatform.onMarkerSelect(mapId: mapId).listen((e) => {
            // _kakaoMapState.widget.onMarkerSelect(e.value)
          });
    }
    if (_kakaoMapState.widget.onCameraIdle != null) {
      _kakaoMapsFlutterPlatform
          .onCameraIdle(mapId: mapId)
          .listen((_) => _kakaoMapState.widget.onCameraIdle!());
    }
    _kakaoMapsFlutterPlatform
        .onMarkerTap(mapId: mapId)
        .listen((MarkerTapEvent e) => _kakaoMapState.onMarkerTap(e.value));
    _kakaoMapsFlutterPlatform.onMarkerDragEnd(mapId: mapId).listen(
        (MarkerDragEndEvent e) =>
            _kakaoMapState.onMarkerDragEnd(e.value, e.position));
    _kakaoMapsFlutterPlatform.onInfoWindowTap(mapId: mapId).listen(
        (InfoWindowTapEvent e) => _kakaoMapState.onInfoWindowTap(e.value));
    _kakaoMapsFlutterPlatform
        .onTap(mapId: mapId)
        .listen((MapTapEvent e) => _kakaoMapState.onTap(e.position!));
    _kakaoMapsFlutterPlatform.onLongPress(mapId: mapId).listen(
        (MapLongPressEvent e) => _kakaoMapState.onLongPress(e.position!));
  }

  /// Updates configuration options of the map user interface.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMapOptions(Map<String, dynamic> optionsUpdate) {
    return _kakaoMapsFlutterPlatform.updateMapOptions(optionsUpdate,
        mapId: mapId);
  }

  /// Updates marker configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMarkers(MarkerUpdates markerUpdates) {
    return _kakaoMapsFlutterPlatform.updateMarkers(markerUpdates, mapId: mapId);
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    return _kakaoMapsFlutterPlatform.animateCamera(cameraUpdate, mapId: mapId);
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return _kakaoMapsFlutterPlatform.moveCamera(cameraUpdate, mapId: mapId);
  }

  /// Sets the styling of the base map.
  ///
  /// Set to `null` to clear any previous custom styling.
  ///
  /// If problems were detected with the [mapStyle], including un-parsable
  /// styling JSON, unrecognized feature type, unrecognized element type, or
  /// invalid styler keys: [MapStyleException] is thrown and the current
  /// style is left unchanged.
  ///
  /// The style string can be generated using [map style tool](https://mapstyle.withgoogle.com/).
  /// Also, refer [iOS](https://developers.google.com/maps/documentation/ios-sdk/style-reference)
  /// and [Android](https://developers.google.com/maps/documentation/android-sdk/style-reference)
  /// style reference for more information regarding the supported styles.
  Future<void> setMapStyle(String mapStyle) {
    return _kakaoMapsFlutterPlatform.setMapStyle(mapStyle, mapId: mapId);
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() {
    return _kakaoMapsFlutterPlatform.getVisibleRegion(mapId: mapId);
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return _kakaoMapsFlutterPlatform.showMarkerInfoWindow(markerId,
        mapId: mapId);
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return _kakaoMapsFlutterPlatform.hideMarkerInfoWindow(markerId,
        mapId: mapId);
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool?> isMarkerInfoWindowShown(MarkerId markerId) {
    return _kakaoMapsFlutterPlatform.isMarkerInfoWindowShown(markerId,
        mapId: mapId);
  }

  Future<void> clearMapTilePersistentCache() {
    return _kakaoMapsFlutterPlatform.clearMapTilePersistentCache(mapId: mapId);
  }

  Future<void> zoomIn() {
    return _kakaoMapsFlutterPlatform.zoomIn(mapId: mapId);
  }

  Future<void> zoomOut() {
    return _kakaoMapsFlutterPlatform.zoomOut(mapId: mapId);
  }

  Future<MapPoint> getMapCenterPoint() {
    return _kakaoMapsFlutterPlatform.getMapCenterPoint(mapId: mapId);
  }

  /// Returns the current zoom level of the map
  Future<double?> getZoomLevel() {
    return _kakaoMapsFlutterPlatform.getZoomLevel(mapId: mapId);
  }

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot() {
    return _kakaoMapsFlutterPlatform.takeSnapshot(mapId: mapId);
  }
}
