import 'package:chatia/providers/change_lang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flag/flag.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SetLangScreen extends ConsumerStatefulWidget {
  const SetLangScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetLangScreenState();
}

class _SetLangScreenState extends ConsumerState<SetLangScreen> {
  final uri = Uri.parse('https://www.facebook.com');
  Future<void> _launchUrl() async {
    if (!await launchUrl(uri,
        webOnlyWindowName: "Test",
        mode: LaunchMode.externalNonBrowserApplication,
        webViewConfiguration: const WebViewConfiguration()))
      throw 'could not launch url';
  }

  @override
  Widget build(BuildContext context) {
    final localisation = AppLocalizations.of(context);
    int? _groupValue = ref.read(appDefaultLocal) == Languages.en ? 1 : 2;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localisation!.choose_lang),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Flag.fromCode(
              FlagsCode.GB,
              width: 35.0,
              height: 35.0,
            ),
            title: Text('Enghish',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            trailing: Radio(
                value: 1,
                groupValue: _groupValue,
                onChanged: (value) {
                  ref.read(appDefaultLocal.notifier).state = Languages.en;
                  setState(() {
                    _groupValue = value;
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: Flag.fromCode(
              FlagsCode.FR,
              width: 35.0,
              height: 35.0,
            ),
            title: Text(
              'Français',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            trailing: Radio(
                value: 2,
                groupValue: _groupValue,
                onChanged: (value) {
                  ref.read(appDefaultLocal.notifier).state = Languages.fr;
                  setState(() {
                    _groupValue = value;
                  });
                }),
          ),
          TextButton(
            onPressed: () async {
              _launchUrl();
            },
            child: Text(
              "Link",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
