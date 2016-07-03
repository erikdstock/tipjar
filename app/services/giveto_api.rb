module GivetoApi# < BaseApi
  BASE = "https://www.give.to/api/1.0"

  def check_artist_verification(artist_name, args = {})
    byebug
    params = {artist_name: artist_name}.merge(args)
    response = handle_response(RestClient.get("#{BASE}/artists", params))
  end

  private
  def handle_response(response)
    status_code = response.code.to_s
    return JSON.parse(response) if status_code == "200"
    if status_code =~ /^4/
      warn 'shits fucked'
      # handle 400-level response
    elsif status_code =~ /^5/
      warn 'lastfms fucked'
      # handle 500-level response
    end
  end
end
