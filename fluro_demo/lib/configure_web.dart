import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Configuring the URL strategy on the web
/// [https://flutter.dev/docs/development/ui/navigation/url-strategies](https://flutter.dev/docs/development/ui/navigation/url-strategies)
void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}
