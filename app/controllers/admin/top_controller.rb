# current_administratorメソッドを利用するため、Admin::Base（/admin/base.rb）クラスを継承。
class Admin::TopController < Admin::Base
  # このコントローラーでは、current_administratorメソッドが実行されないようにする。
  skip_before_action :authorize

  def index
    if current_administrator
      render action: 'dashboard'
    else
      render 'index'
    end
  end
end
