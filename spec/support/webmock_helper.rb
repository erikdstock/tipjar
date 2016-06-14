require_relative 'api_stubs/lastfm_recent_tracks'
require_relative 'api_stubs/lastfm_top_artists'
module WebmockHelper
  def api_stub(stub_name)
    h = ApiStubs.instance_variable_get("@#{stub_name}")
    res = h.to_json
    res
    # File.read("spec/support/api_stubs/#{file}")
  end
end
