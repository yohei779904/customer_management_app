# current_administratorメソッドを利用するため、Admin::Base（/admin/base.rb）クラスを継承。
class Admin::SessionsController < Admin::Base
  # このコントローラーでは、current_administratorメソッドが実行されないようにする。
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      # フォームオブジェクトを作成し、それをインスタンス変数の@formにセット。
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    # 「@form.email」が空でない場合は、「Administrator」オブジェクトを検索する。
    if @form.email.present?
      administrator =
        Administrator.find_by('LOWER(email)= ?', @form.email.downcase)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[:administrator_id] = administrator.id
        session[:admin_last_access_time] = Time.current
        flash.notice = 'ログインしました。'
        redirect_to :admin_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end

    def destroy
      session.delete(:administrator_id)
      flash.notice = 'ログアウトしました。'
      redirect_to :admin_root
    end
  end


  private
    # StrongParameters
    def login_form_params
      params.require(:admin_login_form).permit(:email, :password)
    end
end