import 'package:permission_handler/permission_handler.dart';

/// Result of a permission request.
enum PermissionResult {
  /// Permission was granted.
  granted,

  /// Permission was denied (can ask again).
  denied,

  /// Permission was permanently denied (must go to settings).
  permanentlyDenied,

  /// Permission is restricted (parental controls, enterprise policies).
  restricted,
}

/// Handle camera and storage permissions.
class PermissionService {
  const PermissionService._();

  /// Check and request camera permission.
  ///
  /// Returns the result of the permission request.
  static Future<PermissionResult> requestCamera() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return PermissionResult.granted;
    }

    if (status.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    }

    if (status.isRestricted) {
      return PermissionResult.restricted;
    }

    // Request permission
    final result = await Permission.camera.request();

    if (result.isGranted) {
      return PermissionResult.granted;
    } else if (result.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    } else if (result.isRestricted) {
      return PermissionResult.restricted;
    } else {
      return PermissionResult.denied;
    }
  }

  /// Check current camera permission status without requesting.
  static Future<PermissionResult> checkCamera() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return PermissionResult.granted;
    } else if (status.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    } else if (status.isRestricted) {
      return PermissionResult.restricted;
    } else {
      return PermissionResult.denied;
    }
  }

  /// Open app settings (for permanently denied permissions).
  static Future<bool> openSettings() async {
    return openAppSettings();
  }
}
