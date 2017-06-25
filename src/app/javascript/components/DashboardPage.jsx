import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import ArtistList from 'components/common/ArtistList'
import DashboardToolbar from 'components/dashboard/DashboardToolbar'
import { fetchArtists } from 'actions/artistData'

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
    if (!this.props.artistData.artists) this.refreshArtists()
  }

  refreshArtists () {
    console.log('need artists') // eslint-disable-line
    this.props.dispatch(fetchArtists({ jwt: this.props.session.jwt }))
  }
}

DashboardPage.propTypes = {
  session: PropTypes.object.isRequired,
  artistData: PropTypes.object.isRequired,
  dispatch: PropTypes.func.isRequired
}

function mapStateToProps (state, ownProps) {
  return state
}

// // alternative is to NOT use mapDispatchToProps, in which case dispatch() will be passed in as a prop
// // automatically
// const mapDispatchToProps = (dispatch) => {
//   const refreshArtists = () => {
//     console.log('need artists')
//     dispatch(fetchArtists()) 
//   }

//   return {
//     refreshArtists
//   }
// }

export default connect(mapStateToProps/*, mapDispatchToProps */)(DashboardPage)
