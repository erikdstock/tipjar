import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'

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
}

Header.propTypes = {
  // actions: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return Object.assign({}, { loggedIn: !!state.jwt, user: state.user, constants: state.constants }, ownProps)
}

export default connect(mapStateToProps)(Header)
