import 'babel-polyfill'
import AppRouter from './AppRouter'
import React from 'react'
import configureStore from './store/configureStore'
import { Provider } from 'react-redux'
import { render } from 'react-dom'

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore(window.__INITIAL_DATA__)
  if (window.__INITIAL_DATA__.user && window.__INITIAL_DATA__.user.jwt) {
    localStorage.jwt = window.__INITIAL_DATA__.user.jwt
  }
  render(
    <Provider store={store}>
      <AppRouter />
    </Provider>,
    document.getElementById('app')
  )
})
