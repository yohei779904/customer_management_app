Rails.application.configure do
  # リモートフォームを使わずにform_withメソッドが普通のフォームを作るように設定。
  config.action_view.form_with_generates_remote_forms = false
end