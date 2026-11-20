class AppUrl {

  static const String baseUrl = "https://skilllink-backend-v85z.onrender.com/api/auth";
  static const String sendOtp= "$baseUrl/send-otp/";
  static const String verifyOtp= "$baseUrl/verify-otp/";
  static const String technicianProfile = "$baseUrl/profile/technician/";
  static final String servicesBaseUrl = baseUrl.replaceFirst('/api/auth', '/api/services');
  static final String categories = "$servicesBaseUrl/categories/";
  static final String technicianDashboard = "$servicesBaseUrl/technician/dashboard/";
  static final String technicianIncoming = "$servicesBaseUrl/technician/incoming/";
  static final String technicianHistory = "$servicesBaseUrl/technician/history/";
  static String requestDetail(int id) => "$servicesBaseUrl/requests/$id/";
  static String acceptJob(int id) => "$servicesBaseUrl/requests/$id/accept/";
  static String rejectJob(int id) => "$servicesBaseUrl/requests/$id/reject/";
  static String updateJobStatus(int id) => "$servicesBaseUrl/requests/$id/status/";
  static String uploadJobPhotos(int id) => "$servicesBaseUrl/requests/$id/photos/";
  static String mediaUrl(String? value) {
    if (value == null || value.trim().isEmpty) return '';
    final uri = Uri.tryParse(value.trim());
    if (uri == null) return '';
    final base = Uri.parse(baseUrl);
    if (uri.hasScheme) {
      return uri.host == base.host ? uri.replace(scheme: base.scheme).toString() : uri.toString();
    }
    return base.replace(path: '/', query: null, fragment: null).resolveUri(uri).toString();
  }
}
