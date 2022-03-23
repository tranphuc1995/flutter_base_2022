name="$1"

if [ ! "$name" ]; then
    echo "Please provide bloc name. Example: ./blocgen.sh dashboard"
else
fileNameLowercase=$(echo "$name" | awk '{print tolower($0)}')
classNameUppercase=$(echo "$name" | perl -pe 's/(^|_)./uc($&)/ge;s/_//g')

bloc="lib/bloc/${fileNameLowercase}_bloc.dart"
state="lib/bloc/${fileNameLowercase}_state.dart"
event="lib/bloc/${fileNameLowercase}_event.dart"

mkdir -p -- "lib/bloc"

touch "$bloc"
touch "$state"
touch "$event"

echo -n > $bloc
echo -n > $state
echo -n > $event

echo "part of '${fileNameLowercase}_bloc.dart';

class ${classNameUppercase}State {
  const ${classNameUppercase}State();
}" >> $state

echo "part of '${fileNameLowercase}_bloc.dart';

@immutable
abstract class ${classNameUppercase}Event {}

class SampleAction extends ${classNameUppercase}Event {}

" >> $event

echo "import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '${fileNameLowercase}_state.dart';
part '${fileNameLowercase}_event.dart';

class ${classNameUppercase}Bloc extends Bloc<${classNameUppercase}Event, ${classNameUppercase}State> {
  ${classNameUppercase}Bloc() : super(const ${classNameUppercase}State());

  @override
  Stream<${classNameUppercase}State> mapEventToState(${classNameUppercase}Event event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}
" >> $bloc

fi


