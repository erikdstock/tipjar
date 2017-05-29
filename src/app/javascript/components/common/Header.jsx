import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'
import { Redirect } from 'react-router'
// import { deleteSessionJwt } from 'utils/session'
import { logOut as logOutAction } from 'actions/session'
import { logoutSession } from 'utils/session'

class Header extends React.Component {
  render () {
    let sessionLink
    if (this.props.isLoggedIn) {
      sessionLink = <a onClick={this.props.logout} >Log Out</a>
    } else {
      sessionLink = <a onClick={redirectToLogin}>Log In</a>
    }
    return (
      <nav>
        { sessionLink }
      </nav>
    )
  }
}

Header.propTypes = {
  isLoggedIn: PropTypes.bool.isRequired,
  logout: PropTypes.func.isRequired
  // actions: PropTypes.object.isRequired
}
const redirectToLogin = () => <Redirect to='/login' />

function mapStateToProps (state, ownProps) {
  return Object.assign({}, { isLoggedIn: !!state.session.jwt, user: state.user, constants: state.constants }, ownProps)
}

const mapDispatchToProps = (dispatch) => {
  const logout = () => {
    logoutSession()
    dispatch(logOutAction())
    return <Redirect to='/' />
  }

  return {
    logout
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Header)
export { Header } // for testing
