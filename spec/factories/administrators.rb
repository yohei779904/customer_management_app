FactoryBot.define do
  factory :administrator do
    # sequenceメソッドは、ある属性に連番で値を設定するときに使用する。
    # ブロック変数「 n 」には、このファクトリーが呼ばれた回数がセットされる。
    # :administratorというファクトリーを用いて複数個のadministratorオブジェクトが作られた場合、
    # email属性にはadmin0@example.com、admin1@example.com…と値がセットされていく。
    sequence(:email) {|n|'admin#{n}@example.com'}
    password{'pw'}
    suspended{false}
  end
end