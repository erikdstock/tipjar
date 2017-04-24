import 'babel-polyfill'
import AppRouter from './AppRouter'
import React from 'react'
import configureStore from './store/configureStore'
import { Provider } from 'react-redux'
import { render } from 'react-dom'

const store = configureStore(window.__INITIAL_STATE__)

document.addEventListener('DOMContentLoaded', () => {
  render(
    <Provider store={store}>
      <AppRouter />
    </Provider>,
    document.getElementById('app')
  )
})
