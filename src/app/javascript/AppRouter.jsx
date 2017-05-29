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
    console.log('session jwt is is set: ' + !!sessionStorage.jwt)
    return authyRedirect
  }

  return {
    refreshLoginJwt
  }
}

/* eslint-disable react/display-name */
const authyRedirect = () => sessionStorage.jwt ? <Redirect to="/dashboard" /> : <Redirect to="/login" />
const authyRoute = (Component) => () => {
  console.log('in authyroute')
  if (sessionStorage.jwt) return <Component />
  return <Redirect to="/login" />
}

export default connect(mapStateToProps, mapDispatchToProps)(AppRouter)

// Set session storage to the store's jwt or use an existing one
// ... TODO: Recognize expired/rejected tokens

/* Private routing example... Delete this someday.

function requireAuth (nextState, replace) {
   if (!sessionStorage.jwt) {
     replace({
       pathname: '/login',
       state: { nextPathname: nextState.location.pathname }
     })
   }
 }

 const PrivateRoute = ({ component: Component, ...rest }) => (
   <Route {...rest} render={props => (
     sessionStorage.jwt ? (
       <Component {...props}/>
     ) : (
       <Redirect to={{
         pathname: '/login',
         state: { from: props.location }
       }}/>
     )
   )}/>
 )

 // wrap <Route> and use this everywhere instead, then when
 // sub routes are added to any route it'll work
 const RouteWithSubRoutes = (route) => (
   <Route path={route.path} render={props => (
     // pass the sub-routes down to keep nesting
     <route.component {...props} routes={route.routes}/>
   )}/>
 )

 const AppRouter = () => (
   <Router>
     <div>
       <ul>
         <li><Link to="/tacos">Tacos</Link></li>
         <li><Link to="/sandwiches">Sandwiches</Link></li>
       </ul>

       {routes.map((route, i) => (
         <RouteWithSubRoutes key={i} {...route}/>
       ))}
     </div>
   </Router>
 )
*/
