import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:yuuna/media.dart';
import 'package:yuuna/models.dart';
import 'package:yuuna/pages.dart';
import 'package:yuuna/utils.dart';

/// A media source that allows the user to display an overlay on top of a
/// variety of different external streaming service apps
class PlayerExternalStreamSource extends PlayerMediaSource {
  /// Define this media source.
  PlayerExternalStreamSource._privateConstructor()
      : super(
    uniqueKey: 'player_external_stream',
    sourceName: 'External Stream',
    description: 'Watch videos in external apps.',
    icon: Icons.video_library,
    implementsSearch: false,
    implementsHistory: false,
  );

  /// Get the singleton instance of this media type.
  static PlayerExternalStreamSource get instance => _instance;

  static final PlayerExternalStreamSource _instance =
  PlayerExternalStreamSource._privateConstructor();

  @override
  List<Widget> getActions({
    required BuildContext context,
    required WidgetRef ref,
    required AppModel appModel,
  }) {
    return [
      buildLaunchBGServiceButton(
        context: context,
        ref: ref,
        appModel: appModel,
      ),
    ];
  }

  /// Allows user to pick a video file.
  Widget buildLaunchBGServiceButton({
    required BuildContext context,
    required WidgetRef ref,
    required AppModel appModel,
  }) {
    String settingsLabel =
    appModel.translate('external_stream_launch_bg_service');

    return FloatingSearchBarAction(
      showIfOpened: true,
      child: JidoujishoIconButton(
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
        tooltip: settingsLabel,
        icon: Icons.launch,
        onTap: _launchBackgroundService
      ),
    );
  }

  @override
  BaseSourcePage buildLaunchPage({MediaItem? item}) {
    return PlayerSourcePage(
      item: item,
      source: this,
      useHistory: false,
    );
  }

  @override
  Future<void> onSearchBarTap({
    required BuildContext context,
    required WidgetRef ref,
    required AppModel appModel,
  }) async {
    _launchBackgroundService();
  }

  void _launchBackgroundService() {

  }
}
