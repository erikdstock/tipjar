import React from 'react'
import PropTypes from 'prop-types'
import Header from './common/Header'
import { Route } from 'react-router-dom'
import DashboardPage from './DashboardPage'
import LoginPage from './LoginPage'

class App extends React.Component {
  render () {
    return (
      <div className="react-container">
        <Header />
        {this.props.children}

        <Route exact path="/" component={DashboardPage}/>
        <Route path="/dashboard" component={DashboardPage}/>
        <Route path="/login" component={LoginPage}/>

      </div>
    )
  }
}

export default App
