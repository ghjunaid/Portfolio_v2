import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new tab (or the mail client for `mailto:`). Relative
/// paths such as the resume PDF are resolved against the site's base URL.
/// Empty links are ignored; callers normally hide those buttons anyway.
Future<void> openUrl(String url) async {
  if (url.isEmpty) return;
  final parsed = Uri.parse(url);
  final uri = parsed.hasScheme ? parsed : Uri.base.resolveUri(parsed);
  await launchUrl(
    uri,
    webOnlyWindowName: uri.scheme == 'mailto' ? '_self' : '_blank',
  );
}
