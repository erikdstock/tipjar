import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import rootReducer from '../reducers/rootReducer'

export default function configureStore() {
  return createStore(
    rootReducer,
    applyMiddleware()
  )
}