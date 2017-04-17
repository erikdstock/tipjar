// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'

const LoginPage = props => (
  <div>Login Page!</div>
)

LoginPage.defaultProps = {
  name: 'David'
}

LoginPage.propTypes = {
  name: React.PropTypes.string
}

export default LoginPage
