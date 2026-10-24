// Regenerates the identity and metadata parts of web/index.html and
// web/manifest.json from lib/data/constant.dart, so nothing there is typed
// twice.
//
// Run from the project root after editing lib/data/constant.dart:
//   dart run tool/sync_web.dart
//
// Only the regions between the `<!-- site:… -->` markers in index.html are
// rewritten; everything else in the file is left alone.

import 'dart:convert';
import 'dart:io';

import 'package:junaid_portfolio/data/constant.dart';
import 'package:junaid_portfolio/models/models.dart';

void main() {
  _syncIndex(File('web/index.html'));
  _syncManifest(File('web/manifest.json'));
  stdout.writeln('web/index.html and web/manifest.json are up to date.');
}

void _syncIndex(File file) {
  var html = file.readAsStringSync();
  final eol = html.contains('\r\n') ? '\r\n' : '\n';
  html = _replaceRegion(html, 'head', _head(), eol);
  html = _replaceRegion(html, 'body', _body(), eol);
  file.writeAsStringSync(html);
}

void _syncManifest(File file) {
  final manifest = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  manifest
    ..['name'] = '$ownerName — Portfolio'
    ..['short_name'] = shortName
    ..['description'] = headline;
  file.writeAsStringSync(
    '${const JsonEncoder.withIndent('    ').convert(manifest)}\n',
  );
}

/// Swaps everything between `<!-- site:name -->` and `<!-- /site:name -->`
/// for [lines], keeping the opening marker's indentation.
String _replaceRegion(
  String html,
  String name,
  List<String> lines,
  String eol,
) {
  final pattern = RegExp(
    '([ \\t]*)<!-- site:$name -->[\\s\\S]*?<!-- /site:$name -->',
  );
  final match = pattern.firstMatch(html);
  if (match == null) {
    stderr.writeln('Missing <!-- site:$name --> markers in web/index.html.');
    exit(1);
  }
  final indent = match.group(1)!;
  final body = [
    '$indent<!-- site:$name -->',
    for (final line in lines) line.isEmpty ? '' : '$indent$line',
    '$indent<!-- /site:$name -->',
  ].join(eol);
  return html.replaceRange(match.start, match.end, body);
}

List<String> _head() {
  final url = siteUrl;
  final person = {
    '@context': 'https://schema.org',
    '@type': 'Person',
    'name': ownerName,
    'jobTitle': jobTitle,
    'address': {
      '@type': 'PostalAddress',
      'addressLocality': city,
      'addressRegion': region,
      'addressCountry': countryCode,
    },
    'email': 'mailto:$email',
    'sameAs': [for (final link in _socials) link.$2],
    if (url.isNotEmpty) 'url': '$url/',
  };

  return [
    '<title>${_esc(siteTitle)}</title>',
    _meta('name', 'description', siteDescription),
    _meta('name', 'author', ownerName),
    _meta('name', 'apple-mobile-web-app-title', shortName),
    '',
    // Link previews. The URL and image tags need an absolute address, so
    // they're only written once siteUrl is set.
    _meta('property', 'og:type', 'website'),
    _meta('property', 'og:title', siteTitle),
    _meta('property', 'og:description', shareDescription),
    if (url.isNotEmpty) ...[
      _meta('property', 'og:url', '$url/'),
      _meta('property', 'og:image', '$url/og-image.png'),
      _meta('property', 'og:image:width', '1200'),
      _meta('property', 'og:image:height', '630'),
    ],
    _meta('name', 'twitter:card', 'summary_large_image'),
    _meta('name', 'twitter:title', siteTitle),
    _meta('name', 'twitter:description', shareDescription),
    if (url.isNotEmpty) _meta('name', 'twitter:image', '$url/og-image.png'),
    '',
    '<script type="application/ld+json">',
    // `</` can't appear inside a script tag.
    ...const JsonEncoder.withIndent(
      '  ',
    ).convert(person).replaceAll('</', '<\\/').split('\n'),
    '</script>',
  ];
}

List<String> _body() {
  final links = [
    '<a style="color:#10B981" href="mailto:${_esc(email)}">'
        '${_esc(email)}</a>',
    for (final (label, href) in _socials)
      '<a style="color:#10B981" href="${_esc(href)}">${_esc(label)}</a>',
  ];

  return [
    '<div id="splash" role="status" aria-live="polite">',
    '  <div class="mark" aria-hidden="true">${_esc(initials)}</div>',
    '  <span class="sr-only">${_esc(loadingMessage)}</span>',
    '</div>',
    '',
    '<!-- Plain-text summary for crawlers and visitors without JavaScript. -->',
    '<noscript>',
    '  <main style="max-width:720px;margin:0 auto;padding:32px 16px;'
        'font-family:system-ui,sans-serif;color:#E6EDF3">',
    '    <h1>${_esc(ownerName)}</h1>',
    '    <p>${_esc(headline)}. ${_esc(location)}.</p>',
    '    <p>${_esc(siteDescription)}</p>',
    '    <p>',
    for (final (i, link) in links.indexed)
      '      $link${i < links.length - 1 ? ' ·' : ''}',
    '    </p>',
    '    <p>${_esc(noScriptMessage)}</p>',
    '  </main>',
    '</noscript>',
  ];
}

/// Social profiles from [profile] as (label, url), without the email link.
final _socials = [
  for (final link in profile.socials)
    if (link.kind != SocialKind.email) (link.label, link.url),
];

String _meta(String attr, String key, String content) =>
    '<meta $attr="$key" content="${_esc(content)}">';

String _esc(String s) => s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');
