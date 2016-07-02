module OauthHelpers

  def set_omniauth(opts = {})
    default = {:provider => :lastfm,
               :uuid     => "erikdstock",
               :lastfm => {
                              :name => "erikdstock",
                              :image => "",
                            }
              }

    credentials = default.merge(opts)
    provider = credentials[:provider]
    user_hash = credentials[provider]

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[provider] = {
      'uid' => credentials[:uuid],
      "extra" => {
      "user_hash" => {
        "name" => user_hash[:name],
        "image" => user_hash[:image],
        }
      }
    }
  end

  # def set_invalid_omniauth(opts = {})
  #
  #   credentials = { :provider => :facebook,
  #                   :invalid  => :invalid_crendentials
  #                  }.merge(opts)
  #
  #   OmniAuth.config.test_mode = true
  #   OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
  #
  # end
end
