class LocalizationMap {
  static Map<String, String> codesEN = {
    "welcome_to_login": "Welcome to Login",
    "please_fill_email_password_to_login_your_app_account":
        "Please fill E-mail & password to login your account.",
    "email": "E-mail", //...
    "email_hint": "admin@gmail.com",
    "please_enter_your_email_address": "Please enter your email address",
    "invalid_email_address": "Invalid email address",
    "password": "Password", //...
    "password_hint": "******",
    "please_enter_your_password": "Please enter your password",
    "password_limit": "Password should be greater than 8 characters",
    "password_should_include_1_number": "Password should include 1 number",
    "password_should_1_special_character":
        "Password should include 1 special character",
    "forgot_password_question": "Forgot Password ?",
    "login_now": "Login Now",
    "password_reset_link_sent": "Password reset link sent",
    "forgot_password": "Forgot Password",
    "enter_your_registered_email_to_get_change_password_link":
        "Enter your registered Email to get change password link.", //done
    "save": "Save",
    "enter_email": "Enter email",
    "you_are_not_allowed_to_login": "You are not allowed to login",
    "admin": "Admin",
    "dashboard": "Dashboard",
    "users": "Users",
    "settings": "Settings",
    "change_password": "Change Password",
    "policy": "Policy",
    "privacy_policy": "Privacy Policy",
    "terms_and_condition": "Terms & Condition",
    "logout": "Logout",
    "total_users": "Total Users",
    "all": "All",
    "search": "Search",
    "sr_no": "Sr #",
    "picture": "Picture",
    "name": "Name",
    "date": "Date",
    "email_caps": "Email",
    "status": "Status",
    "action": "Action",
    "no_data": "No Data",
    "please_provide_valid_password": "Please provide valid password",
    "password_changed_successfully": "Password changed successfully",
    "old_password": "Old Password",
    "please_enter_your_old_password": "Please enter your old password",
    "old_password_consists_minimum_8_character":
        "Old password consists minimum 8 character",
    "old_password_should_include_1_number":
        "Old password should include 1 number",
    "old_password_should_include_1_special_char":
        "Old password should include 1 special character",
    "please_enter_your_new_password": "Please enter your new password",
    "new_password_consists_minimum_8_character":
        "New password consists minimum 8 character",
    "new_password_should_include_1_number":
        "New password should include 1 number",
    "new_password_should_include_1_special_char":
        "New password should include 1 special character",
    "field_required": "Field is required", //
    "add": "Add",
    "active": "Active",
    "block": "Block",
    "required": "Field can't be empty",
    "new_password": "New Password",
    "new_password_and_old_password_cannot_be_same":
        "New password and old password cannot be same",
    "created_at": "Created At",
    "updated_at": "Updated At",
    "edit": "Edit",
    "delete": "Delete",
    "content_management": "Content Management",
    "my_profile": "My Profile",
    "user_management": "User Management",
    "basic_detail": "Basic Detail",
    "upload": "Upload",
    "enter_here": "Enter here",
    "categories": "Categories",
    "category": "Category",
    "type": "Type",
    "category_name": "Category Name",
    "add_category": "Add Category",
    "proceed": "Proceed",
    "reports": "Reports",
    "description": "Description",
    "reply": "Reply",
    "category_management": "Category Management",
    "tags": "Tags",
    "total_categories": "Total Categories",
    "my_account": "My Account",
    "edit_profile": "Edit Profile",
    "enter_name": "Enter Name",
    "first_name": "First Name",
    "last_name": "Last Name",
    "are_you_sure_you_want_to_logout": "Are you sure you want to logout?",
    "yes": "Yes",
    "no": "No",
    "profile": "Profile",
    "full_name": "Full Name",
    "popular_categorized": "Popular Categorized",
    "user_detail": "User Detail",
    "": "",
  };

  static String getTranslatedValues(String key) {
    return codesEN[key] ?? "";
  }
}
