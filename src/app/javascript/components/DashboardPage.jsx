import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import ArtistList from 'components/common/ArtistCard'

const DashboardPage = props => (
  <div>
    <ArtistList artistData={props.artistData} />
  </div>
)

DashboardPage.propTypes = {
  artistData: PropTypes.object.isRequired
}
// TODO: Figure out if the router needs to connect() or every container component does
function mapStateToProps (state, ownProps) {
  return state
}

export default connect(mapStateToProps)(DashboardPage)
