class Staff::TopController < Staff::Base
  # このコントローラーでは、current_administratorメソッドが実行されないようにする。
  skip_before_action :authorize

  def index
  end
end
