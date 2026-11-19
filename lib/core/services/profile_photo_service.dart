import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Service managing persistent local profile photo storage outside of SQLite.
class ProfilePhotoService {
  static const String _folderName = 'profile_photos';

  /// Saves a profile photo file locally and returns its persistent absolute path.
  Future<String> saveProfilePhoto(File sourceFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final photoDir = Directory(p.join(appDir.path, _folderName));

    if (!await photoDir.exists()) {
      await photoDir.create(recursive: true);
    }

    final ext = p.extension(sourceFile.path).isNotEmpty
        ? p.extension(sourceFile.path)
        : '.jpg';
    final fileName = 'profile_photo_${DateTime.now().millisecondsSinceEpoch}$ext';
    final targetPath = p.join(photoDir.path, fileName);

    final savedFile = await sourceFile.copy(targetPath);
    return savedFile.path;
  }

  /// Safely deletes the old profile photo if it exists within the app's profile photos directory.
  Future<void> deletePhotoIfExists(String? path) async {
    if (path == null || path.isEmpty) return;

    try {
      final file = File(path);
      if (await file.exists()) {
        // Safety verification: only delete files located inside the profile_photos folder
        final appDir = await getApplicationDocumentsDirectory();
        final photoDirPath = p.join(appDir.path, _folderName);

        if (p.isWithin(photoDirPath, file.path)) {
          await file.delete();
        }
      }
    } catch (_) {
      // Ignored: safe fail if file is locked or missing
    }
  }
}

