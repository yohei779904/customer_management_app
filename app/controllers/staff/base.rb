class Staff::Base < ApplicationController
  # 下記のように記述することで、継承されたコントローラ全てで「before_action」が適用される。
  before_action :authorize
  before_action :check_account

  private def current_staff_member
    if session[:staff_member_id]
      # 「current_staff_member」メソッドが初めて呼ばれたとき「@current_staff_member」
      # の中身はnilである為、演算子||=の右辺が評価されて「@current_staff_member」にセットされる。
      # 2回目以降に呼び出されたときは、「@current_staff_member」に何かしらの値がセット
      # されているので、演算子||=の右辺は評価されずに、そのまま「@current_staff_member」の値が返される。
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end
  # 下記で「current_staff_member」をヘルパーメソッドに登録できる。
  helper_method :current_staff_member

  private def authorize
    unless current_staff_member
      flash.alert = '職員としてログインしてください。'
      redirect_to :staff_login
    end
  end

  private def check_account
    # current_staff_memberメソッドがStaffMemberオブジェクトを返した場合、それに対して
    # active?メソッドを呼び、その結果が偽であれば職員を強制的にログアウトさせる。
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :staff_root
    end
  end

end