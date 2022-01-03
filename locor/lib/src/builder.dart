library locor;

import 'package:build/build.dart';
import 'generators/app_localizations_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder locor(BuilderOptions builderOptions) =>
    SharedPartBuilder(const [AppLocalizationsGenerator()], 'locor');
