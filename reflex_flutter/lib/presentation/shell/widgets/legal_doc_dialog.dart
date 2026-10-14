import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';

enum LegalDocType { privacyPolicy, termsOfService }

/// Displays production Privacy Policy or Terms of Service in a responsive modal.
class LegalDocDialog extends StatelessWidget {
  final LegalDocType docType;

  const LegalDocDialog({super.key, required this.docType});

  static Future<void> show(BuildContext context, LegalDocType docType) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => LegalDocDialog(docType: docType),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPrivacy = docType == LegalDocType.privacyPolicy;
    final title = isPrivacy
        ? LocaleKeys.legal_privacy_policy_title.tr()
        : LocaleKeys.legal_terms_title.tr();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580, maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ReflexColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isPrivacy
                          ? Icons.privacy_tip_rounded
                          : Icons.description_rounded,
                      color: ReflexColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          LocaleKeys.legal_last_updated.tr(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isPrivacy
                        ? _buildPrivacySections()
                        : _buildTermsSections(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  backgroundColor: ReflexColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(LocaleKeys.legal_close.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPrivacySections() {
    return [
      Text(
        LocaleKeys.legal_privacy_intro.tr(),
        style: const TextStyle(fontSize: 13, height: 1.4),
      ),
      const SizedBox(height: 14),
      _section(
        LocaleKeys.legal_privacy_section1_title.tr(),
        LocaleKeys.legal_privacy_section1_body.tr(),
      ),
      _section(
        LocaleKeys.legal_privacy_section2_title.tr(),
        LocaleKeys.legal_privacy_section2_body.tr(),
      ),
      _section(
        LocaleKeys.legal_privacy_section3_title.tr(),
        LocaleKeys.legal_privacy_section3_body.tr(),
      ),
      _section(
        LocaleKeys.legal_privacy_section4_title.tr(),
        LocaleKeys.legal_privacy_section4_body.tr(),
      ),
    ];
  }

  List<Widget> _buildTermsSections() {
    return [
      _section(
        LocaleKeys.legal_terms_section1_title.tr(),
        LocaleKeys.legal_terms_section1_body.tr(),
      ),
      _section(
        LocaleKeys.legal_terms_section2_title.tr(),
        LocaleKeys.legal_terms_section2_body.tr(),
      ),
      _section(
        LocaleKeys.legal_terms_section3_title.tr(),
        LocaleKeys.legal_terms_section3_body.tr(),
      ),
      _section(
        LocaleKeys.legal_terms_section4_title.tr(),
        LocaleKeys.legal_terms_section4_body.tr(),
      ),
    ];
  }

  Widget _section(String heading, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(fontSize: 12.5, height: 1.45),
          ),
        ],
      ),
    );
  }
}
