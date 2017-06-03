import * as types from '../actions/actionTypes'
import initialState from 'reducers/initialState'

// should param be state={artists: []}
export default function artistDataReducer (state = initialState.artistData, action) {
  console.log('artistDataReducer', action)
  switch (action.type) {
    case types.FETCH_ARTISTS_SUCCESS:
      return Object.assign({}, state, { artists: action.artists })
    default:
      return state
  }
}
