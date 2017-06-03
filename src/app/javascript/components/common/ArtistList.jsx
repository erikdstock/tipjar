import React from 'react'
import PropTypes from 'prop-types'
import ArtistCard from 'components/common/ArtistCard'

const ArtistList = props => {
  const {artistData} = props
  const artists = artistData.artists || []
  return (
    <div>
      <h2>Artists of the Month</h2>
      {artists.map((artist) => <ArtistCard name={artist.name} />)}
    </div>
  )
}

export default ArtistList

ArtistList.propTypes = {
  artistData: PropTypes.object.isRequired
}
