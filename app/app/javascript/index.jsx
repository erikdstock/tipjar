import 'babel-polyfill'
import React from 'react'
import { BrowserRouter } from 'react-router-dom'
import App from 'components/App'
import { render } from 'react-dom'
import { Provider } from 'react-redux';
import configureStore from './store/configureStore'

const store = configureStore()

document.addEventListener('DOMContentLoaded', () => {
  render(
    <Provider store={store}>
      <BrowserRouter
        // basename={optionalString}
        // forceRefresh={optionalBool}
        // getUserConfirmation={optionalFunc}
        // keyLength={optionalNumber}
      >
        <App/>
      </BrowserRouter>
    </Provider>,
    document.getElementById('app')
  )
})