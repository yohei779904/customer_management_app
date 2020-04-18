# ここでは、職員をユーザーとして認証するサービスオブジェクトStaff::Authenticatorを作成する。

class Staff::Authenticator
  # StaffMemberオブジェクトを引数としてインスタンス化。
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    # 条件1.与えられたStaffMemberオブジェクトがnilではなく、有効であること。
    # 条件2.開始日が今日以前で、終了日が設置されていないこと。または、開始日が今日より後で、且つ、パスワードが正しいこと。
    @staff_member &&
      !@staff_member.suspended? &&
      @staff_member.start_date <= Date.today &&
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
    BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end