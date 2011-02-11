OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = {
  "uid" => "9876543210",
  "credentials" => {"token" => "myfacebooktoken"},
  "user_info" => {"first_name" => "John", "last_name" => "Doe"}
}

