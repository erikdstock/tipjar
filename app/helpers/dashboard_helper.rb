module DashboardHelper

  # Mutatively Sort top artists. Defaults to at filtering least 5 plays, limit 20 artists by play count
  # @param artists {ActiveRecord::Relation}
  # @param :limit {Fixnum} number of artists to return, default 20
  # @param :min_plays {Fixnum} minimum plays to be displayed, default 5
  # @param :sort_by {Symbol} sort by descriptor - default play_count descending
  # @return {ActiveRecord::Relation} Sorted
  def sort_top_artists!(top_artists, min_plays: 5, limit: 20, sort_by: :play_count)
    result = top_artists.to_a
    result.select! { |top_artist| top_artist.play_count >= min_plays }
          .sort_by!(&sort_by)
          .reverse!
          .slice(0, limit)
  end
end
