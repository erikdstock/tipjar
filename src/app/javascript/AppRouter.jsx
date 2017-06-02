import React from 'react'
import { BrowserRouter, Route, Redirect } from 'react-router-dom'
import PropTypes from 'prop-types'
import DashboardPage from './components/DashboardPage'
import LoginPage from './components/LoginPage'
import Header from './components/common/Header'
import { connect } from 'react-redux'
import { logInSuccess } from 'actions/session'

const AppRouter = (props) => (
  <BrowserRouter
    // basename={optionalString}
    // forceRefresh={optionalBool}
    // getUserConfirmation={optionalFunc}
    // keyLength={optionalNumber}
  >
    <div>
      <Header />
      <Route path="/" render={props.refreshLoginJwt(props.jwt)} />
      <Route path="/dashboard" render={authyRoute(DashboardPage)} />
      <Route path="/login" component={LoginPage} />
    </div>
  </BrowserRouter>
)
      // <PrivateRoute path="/dashboard" render={authyRoute(DashboardPage)}/>

AppRouter.propTypes = {
  jwt: PropTypes.string,
  refreshLoginJwt: PropTypes.func.isRequired
}

function mapStateToProps (state, ownProps) {
  return Object.assign({}, ownProps, { jwt: state.session.jwt })
}

const mapDispatchToProps = (dispatch) => {
  const refreshLoginJwt = (jwt) => {
    if (jwt) {
      sessionStorage.jwt = jwt
    } else if (sessionStorage.jwt) {
      dispatch(logInSuccess(sessionStorage.jwt))
    }
    return authyRedirect
  }

  return {
    refreshLoginJwt
  }
}

/* eslint-disable react/display-name */
const authyRedirect = () => sessionStorage.jwt ? <Redirect to="/dashboard" /> : <Redirect to="/login" />
const authyRoute = (Component) => () => {
  if (sessionStorage.jwt) return <Component />
  return <Redirect to="/login" />
}

export default connect(mapStateToProps, mapDispatchToProps)(AppRouter)
