import 'package:flutter/material.dart';

class SkillsetTagsDisplay extends StatelessWidget {
  final List<String> skillsetTags;
  final void Function(String) onRemoveSkillsetTag;

  const SkillsetTagsDisplay({
    Key? key,
    required this.skillsetTags,
    required this.onRemoveSkillsetTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          children: skillsetTags.map((skill) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            skill,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onRemoveSkillsetTag(skill);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.all(6.0),
                            child: const Icon(
                              Icons.close,
                              size: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
