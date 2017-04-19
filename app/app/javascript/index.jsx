import 'babel-polyfill'
import AppRouter from './AppRouter'
import React from 'react'
import configureStore from './store/configureStore'
import { Provider } from 'react-redux'
import { render } from 'react-dom'

const store = configureStore()

document.addEventListener('DOMContentLoaded', () => {
  render(
    <Provider store={store}>
      <AppRouter />
    </Provider>,
    document.getElementById('app')
  )
})
