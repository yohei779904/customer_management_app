class Admin::Base < ApplicationController
  # 下記のように記述することで、継承されたコントローラ全てで「before_action 」が適用される。
  before_action :authorize
  before_action :check_account

  private def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator

  def authorize
    unless current_administrator
      flash.alert = '管理者としてログインしてください。'
      redirect_to :admin_login
    end
  end

  private def check_account
    # current_administratorメソッドがAdministratorオブジェクトを返した場合、それに対して
    # active?メソッドを呼び、その結果が偽であれば職員を強制的にログアウトさせる。
    if current_administrator && !current_administrator.suspended?
      session.delete(:administrator_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :admin_root
    end
  end
end