import React from 'react'
import { BrowserRouter, Route, Redirect } from 'react-router-dom'
// import App from './components/App'
import DashboardPage from './components/DashboardPage'
import LoginPage from './components/LoginPage'
import Header from './components/common/Header'

console.log(Header)
console.log(LoginPage)
console.log(DashboardPage)

const loggedIn = false

const router = () => (
  <BrowserRouter
    // basename={optionalString}
    // forceRefresh={optionalBool}
    // getUserConfirmation={optionalFunc}
    // keyLength={optionalNumber}
  >
    <div>
      <Header />
      <Route exact path="/" render={() => (
        loggedIn ?
        <Redirect to="/dashboard" /> :
        <Redirect to="/login" />
      )}/>
      <Route path="/login" component={LoginPage}/>
      <Route path="/dashboard" component={DashboardPage}/>
    </div>
  </BrowserRouter>
)

export default router














// function requireAuth (nextState, replace) {
//   if (!sessionStorage.jwt) {
//     replace({
//       pathname: '/login',
//       state: { nextPathname: nextState.location.pathname }
//     })
//   }
// }

// const PrivateRoute = ({ component: Component, ...rest }) => (
//   <Route {...rest} render={props => (
//     sessionStorage.jwt ? (
//       <Component {...props}/>
//     ) : (
//       <Redirect to={{
//         pathname: '/login',
//         state: { from: props.location }
//       }}/>
//     )
//   )}/>
// )

// // wrap <Route> and use this everywhere instead, then when
// // sub routes are added to any route it'll work
// const RouteWithSubRoutes = (route) => (
//   <Route path={route.path} render={props => (
//     // pass the sub-routes down to keep nesting
//     <route.component {...props} routes={route.routes}/>
//   )}/>
// )

// const AppRouter = () => (
//   <Router>
//     <div>
//       <ul>
//         <li><Link to="/tacos">Tacos</Link></li>
//         <li><Link to="/sandwiches">Sandwiches</Link></li>
//       </ul>

//       {routes.map((route, i) => (
//         <RouteWithSubRoutes key={i} {...route}/>
//       ))}
//     </div>
//   </Router>
// )

// export default AppRouter
