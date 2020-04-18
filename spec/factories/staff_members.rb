FactoryBot.define do
  factory :staff_member do
    # sequenceメソッドは、ある属性に連番で値を設定するときに使用する。
    # ブロック変数「 n 」には、このファクトリーが呼ばれた回数がセットされる。
    # :staff_memberというファクトリーを用いて複数個のStaffMemberオブジェクトが作られた場合、
    # email属性にはmember0@example.com、member1@example.com…と値がセットされていく。
    sequence(:email) {|n|'member#{n}@example.com'}
    family_name{'山田'}
    given_name{'太郎'}
    family_name_kana{'ヤマダ'}
    given_name_kana{'タロウ'}
    password{'pw'}
    start_date{Date.yesterday}
    end_date{nil}
    suspended{false}
  end
end