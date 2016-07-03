module GiveToApi # < BaseApi
  BASE = "https://www.give.to/api/1.0".freeze

  def self.check_artist(artist_name, args = {})
    params = {artist_name: artist_name}.merge(args)
    req = RestClient::Request.new(method: :get,
                                  url: "#{BASE}/artists",
                                  payload: params)
    response = JSON.parse(req.execute)
    if response['artists'].length == 1
      artist = response['artists'][0]
      result = {
        url: artist['url'],
        image: artist['image'],
        verified: artist['verified']
      }
      return result
    else
      return false
    end
  end

  private

  def handle_response(response)
    status_code = response.code.to_s
    response = JSON.parse(response)
    return response if status_code == "200" && response['errors'].empty?
    if status_code =~ /^4/
      warn 'shits fucked'
      # handle 400-level response
    elsif status_code =~ /^5/
      warn 'giveto is fucked'
      # handle 500-level response
    end
  end
end
