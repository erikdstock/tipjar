import React from 'react'
import PropTypes from 'prop-types'

const ArtistCard = (props) => {
  const { name } = props
  return (
    <div>
      <h1>{name}</h1>
    </div>
  )
}

ArtistCard.propTypes = {
  name: PropTypes.string.isRequired
}

export default ArtistCard
