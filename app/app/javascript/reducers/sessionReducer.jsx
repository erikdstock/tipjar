import * as types from '../actions/actionTypes'

export default function sessionReducer (state = {}, action) {
  switch (action.type) {
    case types.LOG_OUT:
      return {}
    case types.LOG_IN_SUCCESS:
      return { jwt: action.jwt }
    default:
      return state
  }
}
