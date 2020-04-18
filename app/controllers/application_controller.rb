class ApplicationController < ActionController::Base
  # このset_layoutメソッドは、"staff"または"admin"または"customer"という文字列を返すことになる。
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private def set_layout
    # 『 params[:controller] 』で現在選択されているコントローラの名前を取得する。
    # 『match』で、レシーバ（すなわちURLパス）がその正規表現と合致するかどうかを調べる。
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      # 正規表現に含まれる1番目の括弧で囲まれた部分にマッチした文字列を返す。
      Regexp.last_match[1]
    else
      'customer'
    end
  end
end