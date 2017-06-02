import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import ArtistList from 'components/common/ArtistCard'
import DashboardToolbar from 'components/dashboard/DashboardToolbar'
import {fetchArtists} from 'actions/artistData'

class DashboardPage extends React.Component {
  render () {
    return <div>
      <DashboardToolbar></DashboardToolbar>
      <ArtistList artistData={this.props.artistData} />
    </div>
  }

  componentWillMount () {
    if (!this.props.artistData.artists) this.refreshArtists()
  }

  refreshArtists () {
    console.log('need artists')
    this.props.dispatch(fetchArtists())
  }
}


DashboardPage.propTypes = {
  artistData: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return state
}

export default connect(mapStateToProps)(DashboardPage)
