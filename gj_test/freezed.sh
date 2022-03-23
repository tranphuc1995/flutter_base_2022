
flutter pub add freezed_annotation

flutter pub add build_runner --dev

flutter pub add freezed --dev

flutter pub add json_serializable --dev

echo "analyzer:
  exclude:
    - \"**/*.g.dart\"
    - \"**/*.freezed.dart\"
  errors:
    invalid_annotation_target: ignore" >> analysis_options.yaml

