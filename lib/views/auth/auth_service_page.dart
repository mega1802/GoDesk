import 'package:mydevice/models/login_user_model.dart'; // Adjust import if necessary
import 'package:mydevice/models/organization_model.dart'; // Adjust import if necessary
import 'package:mydevice/services/api_service.dart'; // Adjust import if necessary

class AuthService {
  final DBHelper _DBHelper = DBHelper();

  // Check if the user is already registered
  Future<bool> isUserRegistered(String email) async {
    final List<Map<String, dynamic>> maps = await _DBHelper.getUserByEmail(email);
    return maps.isNotEmpty;
  }

  // Register a new user
  Future<void> registerUser(String firstName, String lastName, String email, String password) async {
    if (await isUserRegistered(email)) {
      throw Exception('User is already registered.');
    }

    await _DBHelper.insertUser(
      LoginUser(
        email: email,
        password: password,
      ),
    );
  }

  // User login
  Future<bool> login({required String email, required String password}) async {
    final List<Map<String, dynamic>> maps = await _DBHelper.getUserByEmailAndPassword(email, password);
    return maps.isNotEmpty;
  }

  // Send OTP to email (stubbed method)
  static Future<void> sendOtp(String email) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate async delay
    // Implement OTP sending logic here
  }

  // Verify OTP (stubbed method)
  static Future<void> verifyOtp(String email, String otp) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate async delay
    // Implement OTP verification logic here
  }

  // Register a new organization
  Future<void> registerOrganization(OrganizationModel organization) async {
    await _DBHelper.insertOrganization(organization);
  }

  // Retrieve organization by ID
  Future<OrganizationModel?> getOrganizationById(int id) async {
    return await _DBHelper.getOrganizationById(id);
  }

  // Update existing organization
  Future<void> updateOrganization(OrganizationModel organization) async {
    await _DBHelper.updateOrganization(organization,updateOrganization);
  }

  // Delete an organization
  Future<void> deleteOrganization(int id) async {
    await _DBHelper.deleteOrganization(id);
  }
}
