# ここでは、職員をユーザーとして認証するサービスオブジェクトAdmin::Authenticatorを作成する。

class Admin::Authenticator
  # administratorオブジェクトを引数としてインスタンス化。
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    @administrator &&
      @administrator.hashed_password&&
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end