import { combineReducers } from 'redux'
import artistDataReducer from 'reducers/artistDataReducer'
import sessionReducer from 'reducers/sessionReducer'
import initialState from 'reducers/initialState'
// import userReducer from './userReducer'

const rootReducer = combineReducers({
  constants: (constants = {}) => constants,
  user: (user = initialState.user) => user,
  session: sessionReducer,
  artistData: artistDataReducer
})

export default rootReducer
