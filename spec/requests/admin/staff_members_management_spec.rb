require 'rails_helper'

describe '管理者による職員管理' do
  # letは、1回目の呼び出しでは普通にメソッドの中身を実行して結果を返す。
  # 同時に、結果を何らかの形で記憶する。
  # 2回目以降の呼び出しでは1回目の結果をそのまま返す。
  let(:administrator) {create(:administrator)}

  before do
    post admin_session_url,
      params: {
        admin_login_form: {
          email: administrator.email, password: 'pw'
        }
      }
    end


  describe '新規登録' do
    # attributes_forはFactoryBotが提供するメソッドであり、
    # 引数としてファクトリーの名前を取り、戻り値としてハッシュを返す。
    # このハッシュは、そのままモデルオブジェクトのassign_attributesメソッドの
    # 引数として使用できるキーと値を持っている。
    let(:params_hash) {attributes_for(:staff_member) }

    example "職員一覧ページにリダイレクト" do
      post admin_staff_members_url, params: { staff_member: params_hash }
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example '例外 ActionController::ParameterMissingが発生' do
      expect {post admin_staff_members_url}.
        to raise_error(ActionController::ParameterMissing)
    end
  end

  describe '更新' do
    let(:staff_member) {create(:staff_member)}
    let(:params_hash) {attributes_for(:staff_member)}

    example 'suspended フラグをセットする' do
      params_hash.merge!(suspended: true)
      patch admin_staff_member_url(staff_member),
        params: {staff_member: params_hash}
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    example 'hashed_passwordの値は書き換え不可' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: 'x')
      expect {
        patch admin_staff_member_url(staff_member),
          params: {staff_member: params_hash}
        }.not_to change {staff_member.hashed_password.to_s}
    end
  end
end