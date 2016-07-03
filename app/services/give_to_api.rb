module GiveToApi # < BaseApi
  BASE = "https://www.give.to/api/1.0".freeze

  def self.check_artist(artist_name, args = {})
    params = {artist_name: artist_name}.merge(args)
    req = RestClient::Request.new(method: :get,
                                  url: "#{BASE}/artists",
                                  payload: params)
    handle_response(req.execute)

  end

  private

  def handle_response(response)
    handle_response_errors(response)
    json_response = JSON.parse(response)
    if json_response['errors'].empty? && json_response['artists'].length == 1
      artist = json_response['artists'][0]
      return {
        url: artist['url'],
        image: artist['image'],
        verified: artist['verified']
      }
    else
      json_response['errors'].each { |e| warn e }
      return false
    end
  end

  def handle_response_errors(response)
    status_code = response.code.to_s
    # handle 400-level response
    if status_code =~ /^4/
      warn 'your shits fucked'
    # handle 500-level response
    elsif status_code =~ /^5/
      warn 'givetos fucked'
    end
  end
end
