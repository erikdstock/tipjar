import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'

const LoginPage = props => (
  <div>Login Page!</div>
)

LoginPage.defaultProps = {
  name: 'David'
}

LoginPage.propTypes = {
  name: PropTypes.string
}

export default LoginPage
