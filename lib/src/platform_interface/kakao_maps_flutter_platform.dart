// Copyright 2020 The yjpark. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';

import 'package:flutter_kakao_map/src/method_channel/method_channel_kakao_maps_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that platform-specific implementations of `kakao_maps_flutter` must extend.
///
/// Avoid `implements` of this interface. Using `implements` makes adding any new
/// methods here a breaking change for end users of your platform!
///
/// Do `extends KakaoMapsFlutterPlatform` instead, so new methods added here are
/// inherited in your code with the default implementation (that throws at runtime),
/// rather than breaking your users at compile time.
abstract class KakaoMapsFlutterPlatform extends PlatformInterface {
  /// Constructs a KakaoMapsFlutterPlatform.
  KakaoMapsFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static KakaoMapsFlutterPlatform _instance = MethodChannelKakaoMapsFlutter();

  /// The default instance of [KakaoMapsFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelKakaoMapsFlutter].
  static KakaoMapsFlutterPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [KakaoMapsFlutterPlatform] when they register themselves.
  static set instance(KakaoMapsFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// /// Initializes the platform interface with [id].
  ///
  /// This method is called when the plugin is first initialized.
  Future<void> init(int mapId) {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// Updates configuration options of the map user interface.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> updateMapOptions(
    Map<String, dynamic> optionsUpdate, {
    required int mapId,
  }) {
    throw UnimplementedError('updateMapOptions() has not been implemented.');
  }

  /// Updates marker configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> updateMarkers(
    MarkerUpdates markerUpdates, {
    required int mapId,
  }) {
    throw UnimplementedError('updateMarkers() has not been implemented.');
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(
    CameraUpdate cameraUpdate, {
    required int mapId,
  }) {
    throw UnimplementedError('animateCamera() has not been implemented.');
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(
    CameraUpdate cameraUpdate, {
    required int mapId,
  }) {
    throw UnimplementedError('moveCamera() has not been implemented.');
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
  Future<void> setMapStyle(
    String mapStyle, {
    required int mapId,
  }) {
    throw UnimplementedError('setMapStyle() has not been implemented.');
  }

  /// Return the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion({
    required int mapId,
  }) {
    throw UnimplementedError('getVisibleRegion() has not been implemented.');
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(
    MarkerId markerId, {
    required int mapId,
  }) {
    throw UnimplementedError(
        'showMarkerInfoWindow() has not been implemented.');
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(
    MarkerId markerId, {
    required int mapId,
  }) {
    throw UnimplementedError(
        'hideMarkerInfoWindow() has not been implemented.');
  }

  Future<void> clearMapTilePersistentCache({
    required int mapId,
  }) {
    throw UnimplementedError(
        'clearMapTilePersistentCache() has not been implemented.');
  }

  Future<void> zoomIn({
    required int mapId,
  }) {
    throw UnimplementedError('zoomIn() has not been implemented.');
  }

  Future<void> zoomOut({
    required int mapId,
  }) {
    throw UnimplementedError('zoomOut() has not been implemented.');
  }

  Future<MapPoint> getMapCenterPoint({
    required int mapId,
  }) {
    throw UnimplementedError('getMapCenterPoint() has not been implemented.');
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool?> isMarkerInfoWindowShown(
    MarkerId markerId, {
    required int mapId,
  }) {
    throw UnimplementedError('updateMapOptions() has not been implemented.');
  }

  /// Returns the current zoom level of the map
  Future<double?> getZoomLevel({
    required int mapId,
  }) {
    throw UnimplementedError('getZoomLevel() has not been implemented.');
  }

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot({
    required int mapId,
  }) {
    throw UnimplementedError('takeSnapshot() has not been implemented.');
  }

  // The following are the 11 possible streams of data from the native side
  // into the plugin

  /// The Camera started moving.
  Stream<CameraMoveStartedEvent> onCameraMoveStarted({required int mapId}) {
    throw UnimplementedError('onCameraMoveStarted() has not been implemented.');
  }

  Stream<CameraCurrentLocationEvent> onCurrentLocationUpdate(
      {required int mapId}) {
    throw UnimplementedError(
        'onCurrentLocationUpdate() has not been implemented.');
  }

  Stream<MarkerSelectEvent> onMarkerSelect({required int mapId}) {
    throw UnimplementedError('onMarkerSelect() has not been implemented.');
  }

  /// The Camera finished moving to a new [CameraPosition].
  Stream<CameraMoveEvent> onCameraMove({required int mapId}) {
    throw UnimplementedError('onCameraMove() has not been implemented.');
  }

  /// The Camera is now idle.
  Stream<CameraIdleEvent> onCameraIdle({required int mapId}) {
    throw UnimplementedError('onCameraMove() has not been implemented.');
  }

  /// A [Marker] has been tapped.
  Stream<MarkerTapEvent> onMarkerTap({required int mapId}) {
    throw UnimplementedError('onMarkerTap() has not been implemented.');
  }

  /// An [InfoWindow] has been tapped.
  Stream<InfoWindowTapEvent> onInfoWindowTap({required int mapId}) {
    throw UnimplementedError('onInfoWindowTap() has not been implemented.');
  }

  /// A [Marker] has been dragged to a different [LatLng] position.
  Stream<MarkerDragEndEvent> onMarkerDragEnd({required int mapId}) {
    throw UnimplementedError('onMarkerDragEnd() has not been implemented.');
  }

  /// A Map has been tapped at a certain [LatLng].
  Stream<MapTapEvent> onTap({required int mapId}) {
    throw UnimplementedError('onTap() has not been implemented.');
  }

  /// A Map has been long-pressed at a certain [LatLng].
  Stream<MapLongPressEvent> onLongPress({required int mapId}) {
    throw UnimplementedError('onLongPress() has not been implemented.');
  }

  /// Returns a widget displaying the map view
  Widget buildView(
      Map<String, dynamic> creationParams,
      Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
      PlatformViewCreatedCallback onPlatformViewCreated) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
