import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import ArtistList from 'components/common/ArtistList'
import DashboardToolbar from 'components/dashboard/DashboardToolbar'
import {fetchArtists} from 'actions/artistData'

class DashboardPage extends React.Component {
  render () {
    return (
      <div>
        <DashboardToolbar></DashboardToolbar>
        <ArtistList artistData={this.props.artistData} />
      </div>
    )
  }

  componentWillMount () {
    if (!this.props.artistData.artists) this.props.refreshArtists()
  }
}

DashboardPage.propTypes = {
  artistData: PropTypes.object.isRequired,
  refreshArtists: PropTypes.func.isRequired
}

function mapStateToProps (state, ownProps) {
  return state
  // if (!state.artistData.artists) {
  //   return Object.assign({}, state, {artists: []})
  // } else {
  //   return Object.assign({}, state, {artists: state.artistData.artists})
  // }
}

const mapDispatchToProps = (dispatch) => {
  const refreshArtists = () => {
    console.log('need artists')
    dispatch(fetchArtists())
  }

  return {
    refreshArtists
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(DashboardPage)
