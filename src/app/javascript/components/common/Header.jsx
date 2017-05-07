import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import { Redirect } from 'react-router'
import { deleteSessionJwt } from 'utils/session'

class Header extends React.Component {
  render () {
    let sessionLink
    if (this.props.loggedIn) {
      sessionLink = <a href='#'>Log Out</a>
    } else {
      sessionLink = <a href='#'>Log In</a>
    }

    return (
      <nav>
        { sessionLink }
      </nav>
    )
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

export { Header } // for testing

export default connect(mapStateToProps)(Header)
