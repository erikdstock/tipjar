import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import ArtistList from 'components/common/ArtistCard'
import DashboardToolbar from 'components/dashboard/DashboardToolbar'

const DashboardPage = props => (
  <div>
    <DashboardToolbar></DashboardToolbar>
    <ArtistList artistData={props.artistData} />
  </div>
)

DashboardPage.propTypes = {
  artistData: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return state
}

export default connect(mapStateToProps)(DashboardPage)
