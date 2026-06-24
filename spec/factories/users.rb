FactoryBot.define do
  factory :user do
    nickname              {Faker::Lorem.characters}
    email                 {Faker::Internet.email}
    #英数字混合・6文字以上・記号なしを保証するため先頭に「1a」を付けました。
    password              {"1a#{Faker::Alphanumeric.alphanumeric(number: 6)}"}
    password_confirmation {password}
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '2000-01-01' }

  end
end