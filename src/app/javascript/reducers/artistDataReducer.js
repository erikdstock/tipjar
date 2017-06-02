import * as types from '../actions/actionTypes'

// should param be state={artists: []}
export default function artistDataReducer (state = {}, action) {
  switch (action.type) {
    case types.FETCH_ARTISTS_SUCCESS:
      console.log('FETCH_ARTISTS_SUCCESS:', action)
      return Object.assign({}, state, { artists: action.artists })
    default:
      return state
  }
}
