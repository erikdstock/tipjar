FactoryGirl.define do
  factory :user do
    password Devise.friendly_token[0, 20]
    email 'user@test.com'
    name 'testuser'
    uid 'testuser'
    provider 'lastfm'
  end

end
