import { combineReducers } from 'redux'
import sessionReducer from './sessionReducer'
// import userReducer from './userReducer'
// import artistDataReducer from './artistDataReducer'

const rootReducer = combineReducers({
  constants: (constants = {}) => constants,
  user: (user = {}) => user,
  session: sessionReducer,
  artistData: (data = {}) => data
})

export default rootReducer
