import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import { Redirect } from 'react-router'
import { deleteSessionJwt } from 'utils/session'
class Header extends React.Component {
  render () {
    if (this.props.loggedIn) {
      return (
        <h1> you are logged in</h1>
      )
    } else {
      return <h1> not logged in </h1>
    }
  }

  logoutAndRedirect () {
    deleteSessionJwt()
    return <Redirect to='/' />
  }
}

Header.propTypes = {
  // actions: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return Object.assign({}, { loggedIn: !!state.session.jwt, user: state.user, constants: state.constants }, ownProps)
}

export default connect(mapStateToProps)(Header)
