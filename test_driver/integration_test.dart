import 'dart:io';

// We need to import this for the screenshots.
import 'package:integration_test/integration_test_driver_extended.dart';

// This would be the line of code without doing screenshots.
// Future<void> main() => integrationDriver();

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (
      String screenshotName,
      List<int> screenshotBytes, [
      Map<String, Object?>? args,
    ]) async {
      final File image =
          await File('screenshots/$screenshotName.png').create(recursive: true);
      image.writeAsBytesSync(screenshotBytes);
      return true;
    },
  );
}
