import 'package:flutter/material.dart';
import 'package:spaces/spaces.dart';
import 'package:yuuna/language.dart';
import 'package:yuuna/pages.dart';
import 'package:yuuna/utils.dart';

/// The content of the dialog used for changing the target language or app
/// locale.
class LanguageDialogPage extends BasePage {
  /// Create an instance of this page.
  const LanguageDialogPage({super.key});

  @override
  BasePageState createState() => _LanguageDialogPageState();
}

class _LanguageDialogPageState extends BasePageState {
  String get dialogCloseLabel => appModel.translate('dialog_close');
  String get targetLanguageLabel => appModel.translate('target_language');
  String get appLocaleLabel => appModel.translate('app_locale');
  String get appLocaleWarning => appModel.translate('app_locale_warning');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: MediaQuery.of(context).orientation == Orientation.portrait
          ? Spacing.of(context).insets.exceptBottom.big
          : Spacing.of(context).insets.exceptBottom.normal,
      content: buildContent(),
      actions: actions,
    );
  }

  List<Widget> get actions => [
        buildCloseButton(),
      ];

  Widget buildCloseButton() {
    return TextButton(
      child: Text(dialogCloseLabel),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget buildContent() {
    ScrollController contentController = ScrollController();

    return SizedBox(
      width: double.maxFinite,
      child: RawScrollbar(
        thumbVisibility: true,
        thickness: 3,
        controller: contentController,
        child: SingleChildScrollView(
          controller: contentController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Spacing.of(context).insets.onlyLeft.small,
                child: Text(
                  targetLanguageLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.unselectedWidgetColor,
                  ),
                ),
              ),
              JidoujishoDropdown<Language>(
                options: appModel.languages.values.toList(),
                initialOption: appModel.targetLanguage,
                generateLabel: (language) => language.languageName,
                onChanged: (language) {
                  appModel.setTargetLanguage(language!);
                  setState(() {});
                },
              ),
              const Space.small(),
              Padding(
                padding: Spacing.of(context).insets.onlyLeft.small,
                child: Text(
                  appLocaleLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.unselectedWidgetColor,
                  ),
                ),
              ),
              JidoujishoDropdown<String>(
                options: JidoujishoLocalisations.localeNames.keys.toList(),
                initialOption: appModel.appLocale.toLanguageTag(),
                generateLabel: (languageTag) =>
                    JidoujishoLocalisations.localeNames[languageTag]!,
                onChanged: (languageTag) {
                  appModel.setAppLocale(languageTag!);
                  setState(() {});
                },
              ),
              const Space.small(),
              ListTile(
                dense: true,
                title: Text.rich(
                  TextSpan(
                    text: '',
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Icon(
                          Icons.info,
                          size: textTheme.bodySmall?.fontSize,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 8),
                      ),
                      TextSpan(
                        text: appLocaleWarning,
                        style: TextStyle(
                          fontSize: textTheme.bodySmall?.fontSize,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
