module TipJar
  module SpecHelpers
    module LastfmApiHelpers
      JSON_SHAPES = {
        recent_track: {
          'artist' => {
            '#text' => 'Yosi Horikawa',
            'mbid' => 'f47738ed-5aba-441f-bae0-8f6c02312286'
          },
          'name' => 'Beer',
          'streamable' => '0',
          'mbid' => '6955dcac-bcbf-4271-acc5-af5c51fc9ba7',
          'album' => {
            '#text' => 'Vapor',
            'mbid' => 'df6f012c-59b8-4f04-8f3a-378ad8f9fc53'
          },
          'url' => 'https://www.last.fm/music/Yosi+Horikawa/_/Beer',
          'image' => [
            {
              '#text' => 'https://lastfm-img2.akamaized.net/i/u/34s/80ff485077234281a4f0a60ebc79f18a.png',
              'size' => 'small'
            },
            {
              '#text' => 'https://lastfm-img2.akamaized.net/i/u/64s/80ff485077234281a4f0a60ebc79f18a.png',
              'size' => 'medium'
            },
            {
              '#text' => 'https://lastfm-img2.akamaized.net/i/u/174s/80ff485077234281a4f0a60ebc79f18a.png',
              'size' => 'large'
            },
            {
              '#text' => 'https://lastfm-img2.akamaized.net/i/u/300x300/80ff485077234281a4f0a60ebc79f18a.png',
              'size' => 'extralarge'
            }
          ],
          'date' => {
            'uts' => '1463851648',
            '#text' => '21 May 2016, 17:27'
          }
        }
      }.freeze
    end
  end
end
