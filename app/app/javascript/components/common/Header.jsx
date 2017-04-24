import React from 'react'
import PropTypes from 'prop-types'
import {connect} from 'react-redux'

class Header extends React.Component {
  render () {
    if (this.props.logged_in) {
      return (
        <h1> you are logged in</h1>
      )
    } else {
      return <h1> not logged in </h1>
    }
  }
}

Header.propTypes = {
  actions: PropTypes.object.isRequired
}

function mapStateToProps (state, ownProps) {
  return {logged_in: state.session} // placeholder
}

export default connect(mapStateToProps)(Header)
