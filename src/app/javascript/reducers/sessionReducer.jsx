import * as types from '../actions/actionTypes'

export default function sessionReducer (state = {}, action) {
  switch (action.type) {
    // Hmm i don't think this is actually being used
    case types.LOG_OUT:
      return {}
    case types.LOG_IN_SUCCESS:
      return Object.assign({}, state, { jwt: action.jwt })
    default:
      return state
  }
}
