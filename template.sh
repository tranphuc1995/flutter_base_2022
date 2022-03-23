#!/bin/bash

package="$1"
localization="$2"

if [[ $package == "-h" || $package == "--help" ]]; then
    echo "Usage: ./template.sh <package_name> [arguments]
-h, --help    Print this usage information.

Available arguments:
  --no-localization         Remove localization. Default(without argument): YES"
else

# create a package template
flutter create --template=package $package

# update project path
cd $package

# delete unnecessary files
rm -f "LICENSE"
rm -f "README.md"
rm -f "CHANGELOG.md"
rm -rf "test"

# internal package must be implemented this
mkdir -p -- "assets/icons"
mkdir -p -- "assets/images"
echo "  assets:
    - assets/images/
    - assets/icons/

publish_to: none" >> pubspec.yaml

# shellscript for images generation
touch imagegen.sh
chmod u+x imagegen.sh

echo "icons_dir=\"assets/icons\"
images_dir=\"assets/images\"
currentPackage=\`basename \"\$PWD\"\`
output=\"lib/generated_images.dart\"
touch \"\$output\"
echo -n > \$output

if [ \"\$(ls -A \$icons_dir)\" ]; then
    echo \"class Ic {\" >> \$output
    for entry in \"\$icons_dir\"/*
        do
        fname=\`basename \$entry\`
        name=\"\${fname%%.*}\"
        lowercase=\$(echo \"\$name\" | awk '{print tolower(\$0)}')
        camelCase=\$(echo \"\$lowercase\" | perl -pe 's/_([a-z])/uc(\$1)/ge')
        if [[ \$camelCase != \"2\" ]]; then
        if [[ \$camelCase != \"3\" ]]; then
        echo \"  static const \$camelCase = 'packages/\$currentPackage/\$entry';\" >> \$output
        fi
        fi
    done
    echo \"}
\" >> \$output
else
    echo ''
fi

if [ \"\$(ls -A \$images_dir)\" ]; then
    echo \"class Img {\" >> \$output
    for entry in \"\$images_dir\"/*
        do
        fname=\`basename \$entry\`
        name=\"\${fname%%.*}\"
        lowercase=\$(echo \"\$name\" | awk '{print tolower(\$0)}')
        camelCase=\$(echo \"\$lowercase\" | perl -pe 's/_([a-z])/uc(\$1)/ge')
        if [[ \$camelCase != \"2\" ]]; then
        if [[ \$camelCase != \"3\" ]]; then
        echo \"  static const \$camelCase = 'packages/\$currentPackage/\$entry';\" >> \$output
        fi
        fi
    done
    echo \"}
\" >> \$output
else
    echo ''
fi
" >> imagegen.sh

# shellscript for freezed 
touch freezed.sh
chmod u+x freezed.sh
echo "
flutter pub add freezed_annotation

flutter pub add build_runner --dev

flutter pub add freezed --dev

flutter pub add json_serializable --dev

echo \"analyzer:
  exclude:
    - \\\"**/*.g.dart\\\"
    - \\\"**/*.freezed.dart\\\"
  errors:
    invalid_annotation_target: ignore\" >> analysis_options.yaml
" >> freezed.sh

# shell script for bloc generation
touch blocgen.sh
chmod u+x blocgen.sh

echo "name=\"\$1\"

if [ ! \"\$name\" ]; then
    echo \"Please provide bloc name. Example: ./blocgen.sh dashboard\"
else
fileNameLowercase=\$(echo \"\$name\" | awk '{print tolower(\$0)}')
classNameUppercase=\$(echo \"\$name\" | perl -pe 's/(^|_)./uc(\$&)/ge;s/_//g')

bloc=\"lib/bloc/\${fileNameLowercase}_bloc.dart\"
state=\"lib/bloc/\${fileNameLowercase}_state.dart\"
event=\"lib/bloc/\${fileNameLowercase}_event.dart\"

mkdir -p -- \"lib/bloc\"

touch \"\$bloc\"
touch \"\$state\"
touch \"\$event\"

echo -n > \$bloc
echo -n > \$state
echo -n > \$event

echo \"part of '\${fileNameLowercase}_bloc.dart';

class \${classNameUppercase}State {
  const \${classNameUppercase}State();
}\" >> \$state

echo \"part of '\${fileNameLowercase}_bloc.dart';

@immutable
abstract class \${classNameUppercase}Event {}

class SampleAction extends \${classNameUppercase}Event {}

\" >> \$event

echo \"import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '\${fileNameLowercase}_state.dart';
part '\${fileNameLowercase}_event.dart';

class \${classNameUppercase}Bloc extends Bloc<\${classNameUppercase}Event, \${classNameUppercase}State> {
  \${classNameUppercase}Bloc() : super(const \${classNameUppercase}State());

  @override
  Stream<\${classNameUppercase}State> mapEventToState(\${classNameUppercase}Event event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}
\" >> \$bloc

fi

" >> blocgen.sh

# add flutter_lints
flutter pub add flutter_lints --dev

touch analysis_options.yaml

echo "include: package:flutter_lints/flutter.yaml
linter:
  rules:
    - always_declare_return_types
    - always_require_non_null_named_parameters
    - annotate_overrides
    - avoid_init_to_null
    - avoid_null_checks_in_equality_operators
    - avoid_relative_lib_imports
    - avoid_return_types_on_setters
    - avoid_shadowing_type_parameters
    - avoid_single_cascade_in_expression_statements
    - avoid_types_as_parameter_names
    - await_only_futures
    - camel_case_extensions
    - curly_braces_in_flow_control_structures
    - empty_catches
    - empty_constructor_bodies
    - library_names
    - library_prefixes
    - no_duplicate_case_values
    - null_closures
    - omit_local_variable_types
    - prefer_adjacent_string_concatenation
    - prefer_collection_literals
    - prefer_conditional_assignment
    - prefer_contains
    - prefer_equal_for_default_values
    - prefer_final_fields
    - prefer_for_elements_to_map_fromIterable
    - prefer_generic_function_type_aliases
    - prefer_if_null_operators
    - prefer_inlined_adds
    - prefer_is_empty
    - prefer_is_not_empty
    - prefer_iterable_whereType
    - prefer_single_quotes
    - prefer_spread_collections
    - recursive_getters
    - slash_for_doc_comments
    - sort_child_properties_last
    - type_init_formals
    - unawaited_futures
    - unnecessary_brace_in_string_interps
    - unnecessary_const
    - unnecessary_getters_setters
    - unnecessary_new
    - unnecessary_null_in_if_null_operators
    - unnecessary_this
    - unrelated_type_equality_checks
    - unsafe_html
    - use_full_hex_values_for_flutter_colors
    - use_function_type_syntax_for_parameters
    - use_rethrow_when_possible
    - valid_regexps" > analysis_options.yaml

# add localization

if [[ $localization == "--no-localization" ]]; then
    echo "no localization"
else
flutter pub add intl_utils --dev
echo "flutter_intl: # Use flutter pub run intl_utils:generate to generate localization
    enabled: true
    class_name: S # Optional. Sets the name for the generated localization class. Default: S
    arb_dir: lib/l10n # Optional. Sets the directory of your ARB resource files. Provided value should be a valid path on your system. Default: lib/l10n
    output_dir: lib/l10n/generated # Optional. Sets the directory of generated localization files. Provided value should be a valid path on your system. Default: lib/generated" >> pubspec.yaml
    
mkdir -p -- "lib/l10n"

touch "lib/l10n/intl_vi.arb"

echo "{
   \"@@locale\": \"vi\",
   \"hello\": \"Xin chào\"
}" > lib/l10n/intl_vi.arb

touch "lib/l10n/intl_en.arb"

echo "{
   \"@@locale\": \"en\",
   \"hello\": \"Hello\"
}" > lib/l10n/intl_en.arb

sleep 2

flutter pub run intl_utils:generate

echo ""
echo "Note 1: Everytime you try to update localization file(ex: intl_vi.arb/intl_en.arb). You should run 'flutter pub run intl_utils:generate' to re generate delegate files."
fi
echo "Note 2: use ./imagegen.sh in the package directory to generate image class if there any in assets foler"
echo "Note 3: use ./blocgen.sh in the package directory to generate blocs class"
echo ""
echo "Created $package package successfully!"

fi

