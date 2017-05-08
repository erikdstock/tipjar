import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import { Redirect } from 'react-router'
import { deleteSessionJwt } from 'utils/session'

class Header extends React.Component {
  render () {
    let sessionLink
    if (this.props.isLoggedIn) {
      sessionLink = <a href='#' onClick={this.logoutAndRedirect} >Log Out</a>
    } else {
      console.log('in login')
      sessionLink = <a href='/login' >Log In</a>
    }
    console.log('rendering')
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
  return Object.assign({}, { isLoggedIn: !!state.session.jwt, user: state.user, constants: state.constants }, ownProps)
}

export default connect(mapStateToProps)(Header)
export { Header } // for testing
