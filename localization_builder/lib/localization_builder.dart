library localization_builder;

import 'package:build/build.dart';
import 'src/generators/app_localizations_generator.dart';
import 'package:source_gen/source_gen.dart';


Builder appLocalizationsBuilder(BuilderOptions builderOptions) => SharedPartBuilder(const [AppLocalizationsGenerator()], 'localization_builder');
