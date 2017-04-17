import React from 'react' 
import { Route } from 'react-router-dom'
import App from './components/App'
import DashboardPage from './components/DashboardPage'
import LoginPage from './components/LoginPage'

const routes = ( // something is not quite working here...
  <Route path="/" component={App}>
    <IndexRoute component={DashboardPage} onEnter={requireAuth} />
    <Route path="/login" component={LoginPage} />
    <Route path="/dashboard" component={DashboardPage} onEnter={requireAuth}>
    </Route>
  </Route>
)

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
// export default routes

const routes = [
  { path: '/',
    component: App
  },
  { path: '/login',
    component: LoginPage,
  },
  {
    path: 'dashboard',
    component: DashboardPage
  }
]

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

export default AppRouter