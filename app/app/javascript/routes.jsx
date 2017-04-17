import React from 'react' 
import { Route, IndexRoute } from 'react-router-dom'
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

export default routes