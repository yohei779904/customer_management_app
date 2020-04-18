Rails.application.configure do
  config.customer_management = {
    staff: {host: 'customer_management.example.com', path: ''},
    admin: {host: 'customer_management.example.com', path: 'admin'},
    customer: {host: 'example.com', path: 'mypage'}
  }
end