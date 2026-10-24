import 'package:flutter/material.dart';

import '../models/models.dart';

/// Material icon for each [ContentIcon] used in `lib/data/constant.dart`.
IconData contentIcon(ContentIcon icon) => switch (icon) {
  ContentIcon.wallet => Icons.account_balance_wallet_outlined,
  ContentIcon.pets => Icons.pets_outlined,
  ContentIcon.voice => Icons.record_voice_over_outlined,
  ContentIcon.notes => Icons.sticky_note_2_outlined,
  ContentIcon.text => Icons.text_fields_rounded,
  ContentIcon.shop => Icons.shopping_bag_outlined,
  ContentIcon.mobile => Icons.phone_iphone_rounded,
  ContentIcon.server => Icons.dns_outlined,
  ContentIcon.code => Icons.code_rounded,
  ContentIcon.database => Icons.storage_rounded,
  ContentIcon.design => Icons.palette_outlined,
  ContentIcon.chip => Icons.memory_rounded,
  ContentIcon.tools => Icons.build_outlined,
};
