import React from 'react'
import { BrowserRouter, Route, Redirect } from 'react-router-dom'
import PropTypes from 'prop-types'
import DashboardPage from './components/DashboardPage'
import LoginPage from './components/LoginPage'
import Header from './components/common/Header'
import { connect } from 'react-redux'

const AppRouter = (props) => (
  <BrowserRouter
    // basename={optionalString}
    // forceRefresh={optionalBool}
    // getUserConfirmation={optionalFunc}
    // keyLength={optionalNumber}
  >
    <div>
      <Header />
      <Route path="/" render={() => (
        updateLoginCreds(props.jwt) ? <Redirect to="/dashboard" /> : <Redirect to="/login" />
      )} />
      <Route path="/login" component={LoginPage}/>
      <Route path="/dashboard" component={DashboardPage}/>
    </div>
  </BrowserRouter>
)

AppRouter.propTypes = {
  jwt: PropTypes.string
}

function mapStateToProps (state, ownProps) {
  // debugger
  // setTimeout(() => console.log(state), 50)
  return Object.assign({}, ownProps, { jwt: state.session.jwt })
}

export default connect(mapStateToProps)(AppRouter)

// Set session storage to the store's jwt or use an existing one
// ... TODO: Recognize expired/rejected tokens
function updateLoginCreds(jwt) {
  if (jwt) return sessionStorage.jwt = jwt
  return sessionStorage.jwt
}





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
