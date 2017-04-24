import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'

// TODO: this stuff should be in constants or state or something?
const lastFmApiKey = '7d78e36b5f99d38316a495aff542f6e6'
const callbackUrl = 'http://localhost:3000/users/auth/lastfm/callback'
const lastFmAuthUrl = `https://last.fm/api/auth?api_key=${lastFmApiKey}&cb=${callbackUrl}`

const LoginPage = props => (
  <div>
    <h1>Log In</h1>
    <a href={lastFmAuthUrl} >LastFm </a>
  </div>
)

// LoginPage.defaultProps = {
//   name: 'David'
// }

// LoginPage.propTypes = {
//   name: PropTypes.string
// }

export default LoginPage
