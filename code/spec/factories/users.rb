FactoryGirl.define do
  factory :user do
    password Devise.friendly_token[0, 20]
    email 'user@test.com'
    name 'erikdstock'
    uid 'erikdstock' # user in lastfm api examples
    provider 'lastfm'
  end

end
