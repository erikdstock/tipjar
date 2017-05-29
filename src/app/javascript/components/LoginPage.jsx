import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'
import {connect} from 'react-redux'
import { Button } from 'react-bootstrap'
// TODO: this stuff should be in constants or state or something?

const LoginPage = props => (
  <div>
    <h1>Log In</h1>
    <Button href={props.lastfmUrl}>Log in with LastFm</Button>
  </div>
)

LoginPage.propTypes = {
  lastfmUrl: PropTypes.string
}
function mapStateToProps (state, ownProps) {
    return Object.assign({}, ownProps, { lastfmUrl: state.constants.LASTFM_AUTH_URL })
}

export default connect(mapStateToProps)(LoginPage)
