import 'babel-polyfill'
import React from 'react'
import createBrowserHistory from 'history/createBrowserHistory'
import routes from './routes'
import { Router } from 'react-router-dom'
import { render } from 'react-dom'
const history = createBrowserHistory()

console.log(routes)
console.log(history)

document.addEventListener('DOMContentLoaded', () => {
  render(
    <Router history={history} routes={routes}/>,
    document.getElementById('app')
  )
})