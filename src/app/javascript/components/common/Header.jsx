import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import { Redirect, Link } from 'react-router'
import { deleteSessionJwt } from 'utils/session'

class Header extends React.Component {
  render () {
    let sessionLink
    if (this.props.loggedIn) {
      sessionLink = <a href='#' onClick={this.logoutAndRedirect} >Log Out</a>
    } else {
      sessionLink = <Link to='/login' >Log In</Link>
    }

    return (
      <nav>
        { sessionLink }
      </nav>
    )
  }

  logoutAndRedirect (e) {
    e.preventDefault()
    deleteSessionJwt()
    return <Redirect to='/' />
  }
}

Header.propTypes = {
  isLoggedIn: PropTypes.bool.isRequired
  // actions: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return Object.assign({}, { loggedIn: !!state.session.jwt, user: state.user, constants: state.constants }, ownProps)
}

export { Header } // for testing

export default connect(mapStateToProps)(Header)
